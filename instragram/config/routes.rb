Rails.application.routes.draw do
  devise_for :users
    

  root 'posts#index'

  # resources :posts

  #index
  get 'posts/' => 'posts#index'

  #Create
  get 'posts/new' => 'posts#new'
  post 'posts/' => 'posts#create'

  #Read
  get 'posts/:id' => 'posts#show'

  #Update
  get 'posts/:id/edit' => 'posts#edit'
  put 'posts/:id' => 'posts#update'

  #Delete
  delete 'posts/:id' => 'posts#delete'


  #user_index
  get 'user/' => 'user#index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 
end


