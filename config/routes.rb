TUCCSA2::Application.routes.draw do
  resources :cs_applications
  resources :ratings
  resources :recommendations
  resources :application_steps
  resources :institutions
  resources :mailing_addresses

  devise_for :users
  root :to => 'cs_applications#index'

  get '/cs_application/send_invitation/:recommendation_id', :controller => 'cs_applications', :action => 'send_invitation', :as => :send_invitation
  get '/cs_application/review/:id', :controller => 'cs_applications', :action => 'review', :as => :review_application
  get '/ratings/verify_password/:id', :controller=>'ratings', :action=>'verify_password', :as => :verify_password
  get '/ratings/submit_password/:id', :controller=>'ratings', :action=>'submit_password', :as => :submit_password
  get '/cs_application/download_package/:id', :controller=>'cs_applications', :action=>'download_package', :as => :download_package
  get '/cs_application/mark_as_reviewed/:id', :controller=>'cs_applications', :action=>'mark_as_reviewed', :as => :mark_as_reviewed
  get '/cs_application/mark_as_denied/:id', :controller=>'cs_applications', :action=>'mark_as_denied', :as => :mark_as_denied
  get '/cs_application/mark_as_approved/:id', :controller=>'cs_applications', :action=>'mark_as_approved', :as => :mark_as_approved
  get '/cs_application/submit_application/:id', :controller=>'cs_applications', :action=>'submit_application', :as => :submit_application
  get '/cs_application/edit/:id', :controller=>'cs_applications', :action=>'edit', :as => :edit_application
  get '/cs_application/remove_attachment/:id', :controller=>'cs_applications', :action=>'remove_attachment', :as=> :remove_attachment
  get '/cs_application/:id/remove_purpose', to: 'cs_applications#remove_purpose', as: 'remove_purpose'

  #devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
