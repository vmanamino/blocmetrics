require 'rails_helper'
include Devise::TestHelpers

RSpec.describe RegisteredApplicationsController, type: :controller do
  describe '#index' do
    context 'Authenticated user' do
      before do
        @user = create(:user)
        sign_in @user
        @apps_user = create_list(:registered_application, 5, user: @user)
        @apps_other = create_list(:registered_application, 5)
      end
      it 'collects registered applications belonging to user' do
        get :index
        apps = assigns(:registered_applications)
        apps.each do |app|
          expect(app.user.id).to eq(@user.id)
        end
        expect(apps.length).to eq(5)
      end
    end
  end
  describe '#show' do
    context 'Authenticated User' do
      before do
        @user = create(:user)
        sign_in @user
        @apps_user = create_list(:registered_application, 5, user: @user)
      end
      it 'shows each registered application belonging to user' do
        @apps_user.each do |app|
          get :show, id: app.id
          app_shown = assigns(:registered_application)
          expect(app_shown).to eq(app)
        end
      end
    end
  end
  describe '#new' do
    context 'Authenticated User' do
      before do
        @user = create(:user)
        sign_in @user
      end
      it 'instantiates a Registered Application' do
        get :new
        app = assigns(:registered_application)
        expect(app).not_to be nil
      end
      it 'Registered Application attributes are nil' do
        get :new
        app = assigns(:registered_application)
        expect(app.id).to be nil
        expect(app.name).to be nil
        expect(app.url).to be nil
      end
    end
  end
  describe '#create' do
    context 'Authenticated User' do
      before do
        @user = create(:user)
        sign_in @user
      end
      context 'Unique Application' do
        it 'message indicates application registered' do
          post :create, registered_application: { name: 'my new app', url: 'http://nowhere2.com' }
          expect(flash[:notice]).to eq('Your application was registered')
        end
        before { post :create, registered_application: { name: 'my new app', url: 'http://nowhere.com' } }
        #  it { should set_flash[:notice] }
        it { should redirect_to(registered_applications_path) }
        it 'saves registered application' do
          app = RegisteredApplication.find_by(name: 'my new app')
          expect(app.url).to eq('http://nowhere.com')
        end
        context 'Invalid attributes' do
          context 'Empty Attributes' do
            it 'produces message application not registered' do
              post :create, registered_application: { name: '', url: 'http://nowhere.com' }
              expect(flash[:error]).to eq('Your application was not registered')
            end
            before { post :create, registered_application: { name: 'my new app', url: '' } }
            it { should redirect_to(registered_applications_path) }
          end
        end
      end
      context 'Duplicate URL Application' do
        before do
          @app_original = create(:registered_application, url: 'http://nowhere.com')
        end
        it 'responds with appropriate message' do
          post :create, registered_application: { name: 'my other new app', url: 'http://nowhere.com' }
          expect(flash[:error]).to eq('Your application was not registered')
          expect(RegisteredApplication.find_by(name: 'my other new app').present?).to be false
        end
      end
    end
  end
  describe '#destroy' do
    context 'Authenticated User' do
      before do
        @user = create(:user)
        @registered_application = create(:registered_application, user: @user)
        sign_in @user
      end
      before { delete :destroy, id: @registered_application.id }
      it { should redirect_to(registered_applications_path) }
      it 'produces message application unregistered' do
        expect(flash[:notice]).to eq('Your application is no longer registered.')
      end
      it 'removes object from database' do
        expect { RegisteredApplication.find(@registered_application.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
