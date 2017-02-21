class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  # POST /resource
  def create
    super
  end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end
end
