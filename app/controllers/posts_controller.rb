# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  # Skip authentication for index and show actions
  skip_before_action :authorize_request, only: [:index, :show]
  before_action :set_post, only: [:show, :update, :destroy]
  before_action :authorize_post, only: [:update, :destroy]

  def index
    if params[:query].present?
      posts = Post.where('title ILIKE ?', "%#{params[:query]}%").page(params[:page]).per(10)
    else
    posts = Post.page(params[:page]).per(10) 
    end# Assuming pagination if needed
    render json: posts, status: :ok
  end

  def show
    render json: @post, status: :ok
  end

  def create
    post = current_user.posts.build(post_params)
    if post.save
      render json: post, status: :created
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render json: @post, status: :ok
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    head :no_content
  end

  def like
    post = Post.find(params[:id])
    post.increment!(:likes_count)
    render json: { likes: post.likes_count }, status: :ok
  end  

  def likes_count
    post = Post.find(params[:id])
    render json: { likes_count: post.likes_count }
  end

  private

  def set_post
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Post not found' }, status: :not_found
  end

  def authorize_post
    render json: { errors: 'Forbidden' }, status: :forbidden unless @post.user_id == current_user.id || current_user.admin?
  end

  def post_params
    params.permit(:title, :content)
  end
end
