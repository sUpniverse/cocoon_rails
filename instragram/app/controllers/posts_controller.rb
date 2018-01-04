class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]
  load_and_authorize_resource param_method: :post_params

  def index
      @posts = Post.where("title Like ?","%#{params["q"]}%").reverse
  end

  
  def new  	
  end

  def create
  	current_user.posts.create(post_params)
  	redirect_to '/'
  end

  def show
  	
  end

  def delete
  	Post.find(params[:id]).destroy
  	redirect_to '/posts'
  end

  def edit
  	
  end  

  def update
  	@post.update(post_params)
  	redirect_to "/posts/#{@post.id}"
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :contents, :Avatar)
    end 
end
