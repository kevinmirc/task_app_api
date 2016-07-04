class Api::V1::ApplicationController < ActionController::API
  include ActionController::Serialization
  # include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate!

  def current_user
    User.find_by(authentication_token: request.headers['Auth-Token'])
  end

  private

  def authenticate!
    if request.headers['Auth-Token']
      User.find_by(authentication_token: request.headers['Auth-Token']) || render_unauthorized
    else
      render_unauthorized
    end
  end

  def render_unauthorized
    render json: {errors: ["Bad Credentials"] }, status: 401
  end

  def render_404_not_found
    render json: {errors: ["Not Found"]}, status: 404
  end

  def render_bad_request
    render json: {errors: ["Bad Request"]}, status: 400
  end
end