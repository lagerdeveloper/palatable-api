class Api::RecipesController < ApplicationController
  respond_to :json

  def index
    render json: Recipe.all
  end
end
