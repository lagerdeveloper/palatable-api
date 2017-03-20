class Users::SessionsController < Devise::SessionsController
  include AuthToken
  skip_before_action :verify_authenticity_token
  respond_to :json

  # POST /resource/sign_in
  def create
    resource = User.find_for_database_authentication(email: sign_in_params[:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(sign_in_params[:password])
      sign_in :user, resource
      token = AuthToken.issue_token({ user_id: resource.id })
      render json: { user_id: resource.id, token: token }
    else
      invalid_login_attempt
    end
  end

  def destroy
    resource = User.find_for_database_authentication(id: params[:user][:id])
    return invalid_destroy_attempt unless resource
    signed_out = sign_out resource
    if signed_out
      render json: { status: :ok, message: 'Signed out successfully' }
    else
      invalid_destroy_attempt
    end
  end

  protected

  def verify_signed_out_user
  end

  def invalid_login_attempt
    render json: { error: 'Invalid email or password.' }, status: 422
  end

  def invalid_destroy_attempt
    render json: { error: 'Error signing out.' }, status: 400
  end

  def sign_in_params
    params.require(:user).permit(:email, :password)
  end

end
