TUCCSA2::Application.routes.draw do

  #for error page
  %w( 404 422 500 ).each do |code|
    get code, :to => "errors#show", :code => code
  end

  resources :cs_applications
  resources :ratings
  resources :recommendations
  resources :application_steps
  resources :institutions
  resources :mailing_addresses
  resources :dashboard

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
  get '/cs_application/remove_transcript/:cs_application_id', :controller=>'cs_applications', :action=>'remove_transcript', :as=> :remove_transcript
  get '/cs_application/remove_purpose/:cs_application_id', :controller=>'cs_applications', :action=>'remove_purpose', :as=> :remove_purpose


  #devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
