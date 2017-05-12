class Api::UserAuthController < Knock::AuthTokenController
  include Knock::Authenticable
  skip_before_action :authenticate, only: [:create_account, :destroy_account]
  before_action :authenticate_user, only: :destroy

  respond_to :json
  # action for creating an account for the user
  def create_account
    user = User.new(sign_up_params)
    if user.save
      render json: user
    else
      render json: { error: user.errors.full_messages }, status: :bad_request
    end
  end

  # action for signing the user in { requires authenticate }
  def create
    render json: {
      token: auth_token.token,
      name: entity.name,
      image: entity.profile_image.url,
      user_id: entity.id,
    }, status: :created
  end

  # action for destroying the users account { requires authenticate_user }
  def destroy_account
    if current_user.destroy
      head :ok
    else
      render json: { error: 'An error occured while deleting your account.' }, status: 500
    end
  end


  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password)
  end

  def entity_name
    'User'
  end
end
