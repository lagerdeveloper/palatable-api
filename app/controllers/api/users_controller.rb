class Api::UsersController < ApplicationController
  respond_to :json
  before_action :verify_jwt_token

  def update
    user = User.find(update_params[:id])
    if user.update(update_params)
      render json: { image: user.profile_image.url }
    else
      head :bad_request
    end
  end

  private

  def update_params
    params.require(:user).permit(:id, :profile_image, :name);
  end
end
