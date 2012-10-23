task :scrape => :environment do
  Dir.chdir('p5wscala_sketches')
  Dir['*'].each do |sketch_name|
    Dir.chdir(sketch_name)
    index_html = Nokogiri::HTML(File.open('index.html')) 

    s = Sketch.find_or_create_by_name(sketch_name)
    s.entry_date ||= Time.local(2011, sketch_name[/[a-zA-Z]+/], sketch_name[/\d+/])
    s.classpath ||= index_html.css('object').last.css('param[name=code]').first['value'].sub(/\/$/, '')
    s.width ||= index_html.css('object').last['width']
    s.height ||= index_html.css('object').last['height']
    s.text_left ||= index_html.css('.left.column').to_html
    s.text_right ||= index_html.css('.right.column').to_html
    s.html ||= nil
    s.save!
    puts "Updating #{s.inspect}"
    Dir.chdir('..')
  end
end

task :remove_docs => :environment do
  Sketch.all.each do |s|
    s.text_left = nil
    s.text_right = nil
    s.html = nil
    s.save!
  end
end
