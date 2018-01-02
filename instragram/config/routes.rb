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
  private
    def set_post
    end

    #strong parameter view단에서 여러개를 던져도 server단에서 원하는것만 골라서 가진다.
    def post_params
      params.require(:post).permit(:title,:content)
    end   
  end  

end
