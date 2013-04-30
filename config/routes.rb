TUCCSA2::Application.routes.draw do
  resources :cs_applications
  resources :ratings
  resources :recommendations
  resources :application_steps
  resources :institutions
  resources :mailing_addresses
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users
  root :to => 'cs_applications#index'
  
  get '/cs_application/send_invitation/:recommendation_id', :controller => 'cs_applications', :action => 'send_invitation', :as => :send_invitation
  get '/cs_application/review', :controller => 'cs_applications', :action => 'review', :as => :review_application
  
  get '/ratings/verify_password/:id', :controller=>'ratings', :action=>'verify_password', :as => :verify_password
  get '/ratings/submit_password/:id', :controller=>'ratings', :action=>'submit_password', :as => :submit_password
  
end
