module ApplicationHelper
  def all_sketches
    Dir['public/p5wscala/*']
  end
end
