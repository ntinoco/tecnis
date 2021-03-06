Tecnisolar::Application.routes.draw do
  

  #resources :product_categories
  resources :categories

  #resources :users
  #get "home/index"
  root :to => "home#index"

  get "sign_in" => "authentication#sign_in"
  post "sign_in" => "authentication#login"
  # Las de abajo faltan:
  get "signed_out" => "authentication#signed_out"
  get "new_user" => "authentication#new_user"
  post "new_user" => "authentication#register"
  get "account_settings" => "authentication#account_settings"
  post "account_settings" => "authentication#set_account_info"

  get "change_password" => "authentication#change_password"
  get "forgot_password" => "authentication#forgot_password"
  
  get "password_sent" => "authentication#password_sent"

  get "forgot_password" => "authentication#forgot_password"
  put "forgot_password" => "authentication#send_password_reset_instructions"

  get "password_reset" => "authentication#password_reset"
  put "password_reset" => "authentication#new_password"

  match 'products/:id/add_to_cart' => 'products#add_to_cart', :as => :add_to_cart
  match 'products/:id/remove_from_cart' => 'products#remove_from_cart', :as => :remove_from_cart
  match 'products/clear_cart' => 'products#clear_cart', :as => :clear_cart
  match 'products/purchase' => 'products#purchase', :as => :purchase
  match 'products/end_purchase' => 'products#end_purchase', :as => :end_purchase
  match 'products/listing' => 'products#listing', :as => :listing
  match 'products/thank_you' => 'products#thank_you', :as => :thank_you

  # Static pages (home)
  match 'ofrecemos' => 'home#ofrecemos', :as => :ofrecemos
  match 'contacto' => 'home#contacto', :as => :contacto
  match 'agua_caliente_sanitaria' => 'home#agua_caliente_sanitaria', :as => :agua_caliente_sanitaria
  match 'calefaccion' => 'home#calefaccion', :as => :calefaccion
  match 'instalaciones_hoteleras_campings' => 'home#instalaciones_hoteleras_campings', :as => :instalaciones_hoteleras_campings
  match 'climatizacion_piscinas' => 'home#climatizacion_piscinas', :as => :climatizacion_piscinas
  match 'instalaciones_agricolas' => 'home#instalaciones_agricolas', :as => :instalaciones_agricolas
  match 'calderas_biomasa' => 'home#calderas_biomasa', :as => :calderas_biomasa
  match 'form' => 'home#form', :as => :form

  match 'submit_mail' => 'home#submit_mail', :as => :submit_mail
  match 'gracias' => 'home#gracias', :as => :gracias

  resources :products
  resources :users

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
