Rails.application.routes.draw do

  get 'admin/admin_home'

  resources :service_requests
  resources :user_service_categories
  resources :service_categories
  devise_for :users, controllers: {registrations: 'registrations'}

  get 'users/non_tasker_signup'
  
  root "pages#home"

  get 'signup' => 'pages#signup'

  get 'login' => 'pages#login'

  get 'professionals' => 'pages#tasker_home', as: 'tasker_home'

  get 'how_it_works' => 'pages#how_it_works'

  get 'privacy_policy' => 'pages#privacy_policy'

  get 'terms_of_service' => 'pages#terms_of_service'

  get 'how_can_we_help' => 'service_categories#formatted_index', as: 'service_category_formatted_index'

  get 'our_team' => 'pages#our_team'

  get 'about' => 'pages#about'

  get 'live' => 'users#live'

  get 'requests' => 'users#requests'

  get 'messages' => 'users#messages'

  get 'update_availability' => 'users#update_availability'

  get 'balance' => 'users#balance'

  get 'admin/home' => 'admin#admin_home', as: 'admin_home'
  
  get 'admin/users' => 'admin#admin_users', as: 'admin_users'

  get 'admin/service_requests' => 'admin#admin_service_requests', as: 'admin_service_requests'

  get 'admin/user/edit/:id' => 'admin#edit_user', as: 'admin_edit_user'

  get 'admin/charges' => 'admin#admin_charges', as: 'admin_charges'

  get 'signup/user' => 'users#non_tasker_signup', as: 'non_tasker_signup'

  get 'signup/tasker' => 'users#tasker_signup', as: 'tasker_signup'

  get 'account_settings' => 'users#account_settings', as: 'account_settings'

  get 'add_profile_photo' => 'users#tasker_needs_image', as: 'add_profile_photo'

  get '/service_request/check_for_acceptance/:requestID', :to => 'service_requests#check_for_acceptance'

  get 's/service_requests/initiate/' => 'service_requests#request_details', as: 'initiate_service_request_no_category'

  get 's/service_request/:service_request_id/review_details' => 'service_requests#review_details', as: 'review_service_request_details'

  get '/service_request/:id/' => 'service_requests#show', as: 'show_service_request'

  post 'service_request/:service_request_id/add_professional/:tasker_id' => 'service_requests#add_tasker', as: 'add_tasker_to_service_request'

  post 'service_request/:service_request_id/confirm_payment' => 'service_requests#confirm_payment', as: 'confirm_payment_for_service_request'

  get 'service_request/:service_request_id/confirmation' => 'service_requests#confirmation', as: 'service_request_submission_confirmation'
  

  get 'service_request/:service_request_id/pay_and_confirm' => 'service_requests#pay_and_confirm', as: 'pay_and_confirm'

  get 's/service_requests/initiate/:service_category_url' => 'service_requests#request_details', as: 'initiate_service_request'

  get 's/service_requests/initiate/:service_category_url/live' => 'service_requests#live_request_details', as: 'initiate_live_service_request'

  get 's/service_requests/initiate/:service_category_url/scheduled' => 'service_requests#scheduled_request_details', as: 'initiate_scheduled_service_request'

  get 's/service_request/:service_request_id/mark_as_complete/complete' => 'service_requests#mark_as_complete', as: 'mark_as_complete'

  get 's/service_request/:service_request_id/mark_as_cancelled/cancel' => 'service_requests#mark_as_cancelled', as: 'mark_as_cancelled'


  get 's/service_request/:service_request_id/complete/confirmation' => 'service_requests#service_request_confirm_complete', as: 'service_request_confirm_complete'

  get 's/service_request/:service_request_id/complete/cancelled' => 'service_requests#service_request_confirm_cancelled', as: 'service_request_confirm_cancelled'

  get 's/service_request/:service_request_id/admin/complete/process_payment' => 'service_requests#admin_process_payment', as: 'service_request_process_payment'



  get 'service_requests/choose_professional/:id' => 'service_requests#service_request_tasker_index', as: 'service_request_tasker_index'

  get 'service_requests/live/search/:id' => 'service_requests#live_search', as: 'service_request_live_search'


  get '/services/:category_url' => 'service_categories#tasker_index', as: 'service_category_home'

  get '/user/add_services' => 'user_service_categories#new', as: 'add_service_to_user'

  get '/user/add_services/:category_url' => 'user_service_categories#new', as: 'add_service_to_user_with_category'

  get '/user/profile/:id' => 'users#profile', as: 'user_profile'

  post 'user/profile/bank_account/add' => 'users#add_bank_account', as: 'add_bank_account'

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
