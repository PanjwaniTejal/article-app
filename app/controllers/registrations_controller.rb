class RegistrationsController < ApplicationController
  skip_before_action :authenticate_user, only: [:create, :confirm]

  # Create user ( Sign up ) 
  def create
    @user = User.new(user_params)
    if @user.save
      render json: { success: "Confirmation email send" }, status: :ok
    else
      render json: { error: @user.errors.messages.map { |msg, desc| msg.to_s + " " + desc[0] }.join(',') }, status: :unauthorized
    end
  end

  # Delete user ( Delete Your Account )
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      render json: { success: "Successfully deleted" }, status: :ok
    else
      render json: { error: "Something went wrong" }, status: :not_found
    end
  end

  # Confirm email address
  def confirm
    token = params[:token]
    user = User.find_by(confirmation_token: token)
    if user && user.valid_confimation_token?
      user.token_confirmed!
      render json: { success: 'User confirmed successfully' }, status: :ok
    else
      render json: { error: 'Invalid token' }, status: :not_found
    end
  end

  private
  def user_params
    params.require(:users).permit(:name, :email, :password, :password_confirmation)
  end
end
