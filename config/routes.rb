Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index'

  resources :posts

  namespace 'api' do
    namespace 'v1' do
      resources :posts
    end
  end
  
end
