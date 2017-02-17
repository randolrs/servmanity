Rails.application.routes.draw do

  resources :service_requests
  resources :user_service_categories
  resources :service_categories
  devise_for :users, controllers: {registrations: 'registrations'}

  get 'users/non_tasker_signup'
  
  root "pages#home"

  get 'signup' => 'pages#signup'

  get 'login' => 'pages#login'

  get 'how_it_works' => 'pages#how_it_works'

  get 'our_team' => 'pages#our_team'

  get 'about' => 'pages#about'

  get 'signup/user' => 'users#non_tasker_signup', as: 'non_tasker_signup'

  get 'signup/tasker' => 'users#tasker_signup', as: 'tasker_signup'

  get 'account_settings' => 'users#account_settings', as: 'account_settings'

  get 's/service_requests/initiate' => 'service_requests#request_details', as: 'initiate_service_request'

  get '/services/:category_url' => 'service_categories#tasker_index', as: 'service_category_home'

  get '/user/add_services' => 'user_service_categories#new', as: 'add_service_to_user'

  get '/user/profile/:id' => 'users#profile', as: 'user_profile'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
