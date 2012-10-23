class Sketch < ActiveRecord::Base
  attr_accessible :name, :entry_date, :classpath, :width, :height, :text_left, :text_right, :html

  #Gets the previous sketch, sorted by date
  def previous
    sorted = Sketch.order('entry_date DESC')
    my_index = sorted.index(self)
    sorted[my_index-1]
  end

  #Gets the next sketch, sorted by date
  def next
    sorted = Sketch.order('entry_date DESC')
    my_index = sorted.index(self)
    sorted[(my_index+1)%sorted.length]
  end

  #url to this sketch's jarfile
  def jarfile
    "/p5wscala_sketches/#{name.capitalize}.jar"
  end

  #url to this sketch's sourcefile
  def sourcefile
    "/p5wscala_sketches/#{name}.scala"
  end

  #Does this sketch have a picture?
  def picture?  
    File.exists? "#{Rails.root}/public/#{picture}"
  end

  #url to this sketch's icon picture
  def picture
    "p5wscala_sketches/#{name}.png"
  end

  def format
    if width > 600
      :long
    else
      :compact
    end
  end
end
