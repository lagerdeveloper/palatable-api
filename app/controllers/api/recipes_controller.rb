class Api::RecipesController < ApplicationController
  before_action :verify_jwt_token, only: :create
  respond_to :json

  def index
    render json: Recipe.includes(:ingredients).all
  end

  def create
  end
end
