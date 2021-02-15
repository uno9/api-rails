module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, only: [:show, :edit, :update, :destroy]

      def index
        @posts = Post.order(created_at: :desc)
        render json: { 
          status: 'SUCCESS', 
          message: 'Loaded posts', 
          data: @posts
        }
      end

      def show
        render json: { 
          status: 'SUCCESS', 
          message: 'Loaded the post', 
          data: @post 
        }
      end

      def create
        post = Post.new(
          title: post_params[:title],
          description: post_params[:description],
          limit: post_params[:limit]
        )

        if post.save
          render json: { 
            status: 'SUCCESS', 
            message: 'Post title', 
            data: post
          }
        else
          render json: { 
            status: 'ERROR', 
            message: 'Not Post title', 
            data: post.errors 
          }
        end
      end

      def destroy
        @post.destroy
        render json: { 
          status: 'SUCCESS', 
          message: 'Deleted the post', 
          data: @post 
        }
      end

      def update
        if @post.update(post_params)
          render json: { 
            status: 'SUCCESS', 
            message: 'Updated the post', 
            data: @post
          }
        else
          render json: { 
            status: 'ERROR', 
            message: 'Not updated', 
            data: @post.errors 
          }
        end
      end

      private

      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.require(:post).permit(:title, :description, :limit)
      end
    end
  end
end