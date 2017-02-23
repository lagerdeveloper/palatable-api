class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token
  respond_to :json

  # POST /resource
  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render json: { error: user.errors }
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
