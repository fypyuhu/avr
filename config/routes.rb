Rails.application.routes.draw do


  get 'makker/heading' =>'images_makker#heading'

  get 'makker/paragraph'=>'images_makker#paragraph'

  get 'makker/create'=>'images_makker#create'

  get 'images/create'

  get 'user/index'

  get 'user/myvideos'
  get 'admin/index'

  get 'user/video/' =>'user#myvideos'

  get 'user/video/article' =>'article#index'
  get 'user/video/article/scrap' =>'article#scrap'

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
