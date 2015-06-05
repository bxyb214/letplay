Rails.application.routes.draw do
  resources :users, except: [:new, :edit]
  resources :activities, except: [:new, :edit]
  get "filter/activities" => 'activities#filter'
  get "activity/participate" => 'activities#participate'
  get "login" => 'users#login'
end