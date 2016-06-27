class Api::V1::ApplicationController < ActionController::API
  include ActionController::Serialization
  # include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate!

  private

  def authenticate!
    if request.headers['Auth-Token']
      User.find_by(authentication_token: request.headers['Auth-Token']) || render_unauthorized
    else
      render_unauthorized
    end
  end

  def render_unauthorized
    render json: {errors: ['Bad Credentials.'] }, status: 401
  end

  def render_404_not_found
    render json: {error: "Not Found"}, status: 404
  end
end