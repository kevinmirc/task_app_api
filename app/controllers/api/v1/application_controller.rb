class Api::V1::ApplicationController < ActionController::API
  include ActionController::Serialization
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate!

  private

  def authenticate!
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token,options|
      User.find_by(authentication_token: token)
    end
  end

  def render_unauthorized
    render json: {errors: ['Bad Credentials'] }, status: 401
  end
end