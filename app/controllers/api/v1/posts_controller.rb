module Api
    module V1

        class PostsController < ApplicationController

            def index
                posts = Post.all
                render json: { status: 'success', message: 'Loaded successfully', data: posts }, status: :ok
            end

            def show
                post = get_article params[:id]
                if post.eql? nil
                    render json: { status: 'error', message: 'Cannot find the post' }, status: :not_found
                else
                    render json: { status: 'success', message: 'Post found', data: post_response(post)}, status: :ok
                end
            end

            def update
                post = get_post params[:id]
                if post.eql? nil
                    render json: { status: 'error', message: 'Cannot find post' }, status: :unprocessable_entity
                else
                    if post.update_attributes(posts_params)
                        render json: { status: 'success', message: 'Post updated', data: post_response(post)}, status: :ok
                    else
                        render json: { status: 'error', message: 'Post cannot be updated' }, status: :ok
                    end
                end
            end

            def create
                post = Post.new(posts_params)
                if post.save
                    render json: { status: 'success', message: 'Post created', data: post_response(post) }, status: :created
                else
                    render json: { status: 'error', message: 'Post cannot be created' }, status: :unprocessable_entity
                end
            end

            def destroy
                post = get_post params[:id]
                if post.eql? nil
                    render json: { status: 'error', message: 'Cannot find post' }, status: :unprocessable_entity
                else
                    if post.destroy
                        render json: { status: 'success', message: 'Post deleted' }, status: :ok
                    end
                end
            end

            private def posts_params
                params.permit(:title, :body)
            end

            private def post_response(article)
                data = {
                    id: post.id,
                    title: post.title,
                    description: post.description
                }
            end

            private def get_post(id)
                Post.where(id: id).first
            end
        end

    end
end
