class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  respond_to :json

  # POST /resource/sign_in
  def create
    resource = User.find_for_database_authentication(email: sign_in_params[:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(sign_in_params[:password])
      sign_in :user, resource
      render json: { user_email: resource.email }
    end
    invalid_login_attempt
  end

  protected

  def invalid_login_attempt
    render json: { invalid: 'Invalid email or password.' }
  end

  def sign_in_params
    params.require(:user).permit(:email, :password)
  end

end
