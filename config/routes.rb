Rails.application.routes.draw do
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'

  get   '/signup' , to: 'users#signup'  , as: 'signup'
  post  '/signup' , to: 'users#create'  , as: 'signup_submit'
  get   '/login'  , to: 'users#login'   , as: 'login'
  get   '/logout' , to: 'users#logout'  , as: 'logout'
  post  '/auth'   , to: 'users#auth'    , as: 'auth'

  get   '/dashboard', to: 'dashboard#index'

  get   '/tag/:slug'  , to: 'posts#by_tag'
  get   '/tag'        , to: 'posts#tags'
  get   '/:slug'      , to: 'posts#single'
end
