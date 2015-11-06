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
    @registered_application = RegisteredApplication.new
    authorize @registered_application
  end

  def create
    registered_application = current_user.registered_applications.build(app_params)
    authorize registered_application
    if registered_application.save
      flash[:notice] = 'Your application was registered'
      redirect_to registered_applications_path
    else
      flash[:error] = 'Your application was not registered'
      redirect_to registered_applications_path
    end
  end

  def destroy
    registered_application = RegisteredApplication.find(params[:id])
    authorize registered_application
    if registered_application.destroy
      flash[:notice] = 'Your application is no longer registered.'
      redirect_to registered_applications_path
    else
      flash[:error] = 'Your application is still registered'
      render :show
    end
  end

  private

  def app_params
    params.require(:registered_application).permit(:name, :url)
  end
end
