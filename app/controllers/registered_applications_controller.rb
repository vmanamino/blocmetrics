class RegisteredApplicationsController < ApplicationController
  def index
    @registered_applications = RegisteredApplication.visible_to(current_user)
    authorize @registered_applications
  end

  def show
    @registered_application = RegisteredApplication.find(params[:id])
    authorize @registered_application
  end

  def new
  end
end
