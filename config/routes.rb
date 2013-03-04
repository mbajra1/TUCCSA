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
end
