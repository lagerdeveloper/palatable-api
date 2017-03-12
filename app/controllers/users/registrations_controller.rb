class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token
  respond_to :json

  # POST /resource
  def create
    user = User.find_by(email: user_params[:email])
    if user
      return invalid_registration('An account with that email already exists.')
    end
    user = User.new(user_params)
    if user.save
      render json: user
    else
      invalid_registration(user.errors)
    end
  end

  private

  def invalid_registration(message)
    render json: { status: 500, errors: message }
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
