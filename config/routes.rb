Rails.application.routes.draw do
  root 'user_files#landing'
  resources :user_files
end
