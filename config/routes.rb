Rails.application.routes.draw do
  get 'passwords/new'
  get 'passwords/edit'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :songs

  root to: 'songs#index'

  get 'reset' => 'passwords#new'
  post 'reset' => 'passwords#create'
  get 'reset/:code' => 'passwords#edit', as: :reset_code
  put 'reset/:code' => 'passwords#update'

end
