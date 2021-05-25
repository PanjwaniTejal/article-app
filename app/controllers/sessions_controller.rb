class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]
  # Login user into application
  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password]) # User exist and check password is match 
      if @user.confirm? # Check verify email address or not 
        token = JsonWebTokenService.encode({ email: @user.email })
        render json: { auth_token: token }
      else
        render json: { error: "Please verify email address" }, status: :unauthorized
      end
    else
      render json: { error: "Incorrect Email Or password" }, status: :unauthorized
    end
  end

  # Log out user from application
  def destroy
    render json: { current_user: current_user }
  end
end
