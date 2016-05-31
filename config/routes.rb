Rails.application.routes.draw do
  root 'user_files#index'
  resources :user_files
end
