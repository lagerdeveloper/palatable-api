class Users::SessionsController < Devise::SessionsController
  include AuthToken
  skip_before_action :verify_signed_out_user
  before_action :verify_jwt_token, only: :destroy
  respond_to :json

  # POST /resource/sign_in
  def create
    resource = User.find_for_database_authentication(email: sign_in_params[:email])
    return invalid_login_attempt('Account with that email does not exist.') unless resource

    if resource.valid_password?(sign_in_params[:password])
      sign_in :user, resource
      token = AuthToken.issue_token({ user_id: resource.id })
      render json: {
        user_id: resource.id,
        name: resource.name,
        image: resource.profile_image.url,
        token: token,
      }
    else
      invalid_login_attempt('Incorrect password')
    end
  end

  def destroy
    resource = User.find_for_database_authentication(id: params[:user][:id])
    return invalid_destroy_attempt('Error, user does not exist.') unless resource
    head :ok
  end

  protected

  def invalid_login_attempt(message)
    render json: { error: message }, status: 422
  end

  def invalid_destroy_attempt(message)
    render json: { error: 'Error signing out.' }, status: 400
  end

  def verify_jwt_token
    head :unauthorized if request.headers['Authorization'].nil? ||
       !AuthToken.valid_token?(request.headers['Authorization'].split(' ').last)
  end

  def sign_in_params
    params.require(:user).permit(:email, :password)
  end

end
