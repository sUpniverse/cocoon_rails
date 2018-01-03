class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
      @posts = Post.where("title Like ?","%#{params["q"]}%").reverse
  end

  def new  	
  end

  def create
  	Post.create(
  		title: params[:title],
  		contents: params[:contents],
      Avatar: params[:Avatar]
  		)
  	redirect_to '/'
  end

  def show
  	@post = Post.find(params[:id])
  end

  def delete
  	Post.find(params[:id]).destroy
  	redirect_to '/posts'
  end

  def edit
  	@post = Post.find(params[:id])
  end  

  def update
  	@post = Post.find(params[:id])
  	@post.update(
  		title: params[:title],
  		contents: params[:contents],
      Avatar: params[:Avatar]
  		)
  	redirect_to "/posts/#{@post.id}"
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content, :Avatar)
    end 


end
