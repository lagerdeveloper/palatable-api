class Users::RegistrationsController < Devise::RegistrationsController
  include AuthToken
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_scope!
  before_action :verify_jwt_token, only: :destroy
  respond_to :json

  # POST /resource
  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      invalid_registration(user.errors.full_messages.first)
    end
  end

  def destroy
    user = User.find_by(id: params[:user][:id])
    return invalid_destroy_attempt unless user
    if user.destroy
      head :ok
    else
      invalid_destroy_attempt
    end
  end

  private

  def invalid_registration(message)
    render json: { error: message }, status: :bad_request
  end

  def invalid_destroy_attempt
    render json: { error: 'There was an error deleting your account.' }, status: :bad_request
  end

  def verify_jwt_token
    head :unauthorized if request.headers['Authorization'].nil? ||
       !AuthToken.valid_token?(request.headers['Authorization'].split(' ').last)
  end

  def user_params
    params.require(:user).permit(:email, :password, :name)
  end
end
