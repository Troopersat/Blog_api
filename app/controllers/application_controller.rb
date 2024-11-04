# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  include Pundit

  before_action :authorize_request
  attr_reader :current_user

  # Global error handling
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from JWT::DecodeError, with: :unauthorized

  private

  def authorize_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    @current_user = User.find(JsonWebToken.decode(token)[:user_id])
    Rails.logger.info "Authorized user: #{@current_user.id}"
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError
    render json: { errors: 'Unauthorized' }, status: :unauthorized
  end

  def not_found
    render json: { error: 'Resource not found' }, status: :not_found
  end

  def unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
