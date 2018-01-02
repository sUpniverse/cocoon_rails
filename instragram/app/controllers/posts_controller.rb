class PostsController < ApplicationController
  def index
  	@posts = Post.all.reverse
  end

  def new  	
  end

  def create
  	Post.create(
  		title: params[:title],
  		contents: params[:contents]
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
  		contents: params[:contents]
  		)
  	redirect_to "/posts/#{@post.id}"
  end
end
