class Api::V1::SessionsController < Api::V1::ApplicationController
  skip_before_action :authenticate!, only: [:create]

  def create
    user = User.authenticate(params.permit(:email, :password))
    if user
      render json: {user: user}, status: 200
    else
      render_bad_request
    end
  end
end
