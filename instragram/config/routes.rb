Rails.application.routes.draw do
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

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 
end


