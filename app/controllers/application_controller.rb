class ApplicationController < ActionController::Base
  include AuthToken
  protect_from_forgery with: :exception

  protected

  def verify_jwt_token
    head :unauthorized if request.headers['Authorization'].nil? ||
       !valid_token?(request.headers['Authorization'].split(' ').last)
  end
end
