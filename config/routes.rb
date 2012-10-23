Website::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'homepage#index'

  # See how all your routes lay out with "rake routes"

  match '/contact' => 'contact#index'
  # Redirect to end with a slash
  match '/p5wscala/:sketch_name' => redirect('/p5wscala/%{sketch_name}/'), :constraints => lambda {|r| !r.original_fullpath.end_with?('/')}
  match '/p5wscala/:sketch_name/' => 'projects#p5wscala_sketch', :constraints => { :sketch_name => /[a-zA-Z0-9]+/ }, :format => false

  match '/projects/p5wscala/sketches/:sketch_name' => redirect('/p5wscala/%{sketch_name}/')

  match '/p5wscala/:sketch_name/:file' => redirect('/p5wscala_sketches/data/%{file}.%{format}')

end
