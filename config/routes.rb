Rails.application.routes.draw do


  get 'user/index'

  get 'user/myvideos'
  get 'admin/index'

  get 'user/video/' =>'user#myvideos'

  get 'user/video/article' =>'article#index'

  devise_for :users
  get 'home/index'
  get 'home/indexjson'


  root 'home#index'

  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
    get 'signin' => 'devise/sessions#new'
    post 'signin' => 'devise/sessions#create'

  end
  end
