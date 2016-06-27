class Api::V1::UsersController < Api::V1::ApplicationController
  skip_before_action :authenticate!, only: [:create]

  def index
    render json: User.all
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: {
        user: user
      }, status: 201
    else
      render json: {
        error: "User not created",
      }, status: 400
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end