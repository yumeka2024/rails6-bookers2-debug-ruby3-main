Rails.application.routes.draw do
  
  # get 'searches/search'
  # get 'relationships/follower'
  # get 'relationships/followed'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  root :to => "homes#top"
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
   resource :favorite, only: [:create, :destroy]
   resources :book_comments, only: [:create, :destroy]
  end
  
  # resources :users, only: [:index,:show,:edit,:update] do
  #   resource :relationship, only: [:create, :destroy]
  #   get 'follower' => 'relationships#follower', as: 'follower'
  #   get 'followed' => 'relationships#followed', as: 'followed'
  # end
  
  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
  	get "followings" => "relationships#followings", as: "followings"
  	get "followers" => "relationships#followers", as: "followers"
  end
  
  get "/search", to: "searches#search"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end