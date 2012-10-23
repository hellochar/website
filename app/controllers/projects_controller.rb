class ProjectsController < ApplicationController

  # Render a sketch page; this action corresponds to urls like /p5wscala/nov2b
  def p5wscala_sketch
    sketch_name = params[:sketch_name]
    sketch = Sketch.where(:name => sketch_name).first
    if sketch.format == :compact
      render 'p5wscala/sketch_compact', :layout => 'p5wscala_sketch', :locals => {:sketch => sketch}
    else
      render 'p5wscala/sketch_long', :layout => 'p5wscala_sketch', :locals => {:sketch => sketch}
    end
  end

end
