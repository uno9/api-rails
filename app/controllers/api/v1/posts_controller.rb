class Api::V1::PostsController < ApplicationController

  def index
    @post = Post.all
    render json: @post
  end

  def show
    @post = Post.find(params[:id])
    render json: @post
  end

  def create
    @post = Post.new(**posts_params)

    if @post.save
    else
      render 'new'
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(posts_params)
      render json: @post
    else
      render json: @post.errors 
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    render json: { 
      status: 'SUCCESS', 
      message: 'Deleted the post'
    }
  end

  private

    def posts_params
      params.require(:post).permit(:title, :description, :limit)
    end
end
