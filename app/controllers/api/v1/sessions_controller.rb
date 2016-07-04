class Api::V1::SessionsController < Api::V1::ApplicationController
  skip_before_action :authenticate!

  def create
    user = User.authenticate(params.permit(:email, :password))
    if user
      render json: {user: user}, status: 200
    else
      render_bad_request
    end
  end

  def facebook
    require 'net/http'

    if params[:facebook_token]
      facebook_user = get_facebook_user(params[:facebook_token])
      user = User.find_by(email: facebook_user["email"]) || User.create(email: facebook_user["email"], password: Devise.friendly_token.first(10))
      render json: {user: user}, status: 200
    else
      render json: {messages: ["Missing paramater: `facebook_token`"]}, status: 400
    end
  end

  private

  def get_facebook_user(token)
    uri = URI.parse("https://graph.facebook.com/v2.6/me?fields=id%2Cname%2Cemail&access_token=" + params[:facebook_token])
    res = Net::HTTP.get_response(uri)
    facebook_user = JSON.parse(res.body)
  end
end
