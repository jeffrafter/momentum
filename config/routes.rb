ActionController::Routing::Routes.draw do |map|  
  map.resources :intervals, :collection => {:categories => :get}
  map.root :controller => "intervals"
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
