class ApplicationController < ActionController::Base
  include AuthToken
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  protected

  def verify_jwt_token
    head :unauthorized if request.headers['Authorization'].nil? ||
       !AuthToken.valid_token?(request.headers['Authorization'].split(' ').last)
  end
end
