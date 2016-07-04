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
    if !params[:facebook_token]
      respond_with_missing_params_error("facebook_token") 
    else
      facebook_response = get_facebook_user(params[:facebook_token])

      if facebook_response[:error]
        render json: {errors: [facebook: facebook_response[:error]]}, status: 400
      else
        if user = User.find_or_create_from_facebook_data!(facebook_response)
          render json: {user: user}, status: 200
        else
          render json: {errors: ["Problem creating/finding user via facebook"]}, status: 500
        end
      end
    end
  end

  private

  def get_facebook_user(token)
    require 'net/http'
    uri = URI.parse("https://graph.facebook.com/v2.6/me?fields=id%2Cname%2Cemail&access_token=" + token)
    res = Net::HTTP.get_response(uri)
    res = eval(res.body)
  end
end
