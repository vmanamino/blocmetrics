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
        @apps_other = create_list(:registered_application, 5)
      end
      it 'shows each registered application belonging to user' do
        @apps_user.each do |app|
          get :show, id: app.id
          app_shown = assigns(:registered_application)
          expect(app_shown).to eq(app)
          expect(app_shown.user).to eq(@user)
        end
      end
      xit 'denies app not belonging to user' do

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
      before { post :create, registered_application: { name: 'my new app', url: 'http://nowhere.com' } }
      it { should redirect_to(registered_applications_path) }
      it 'message indicates application registered' do
        post :create, registered_application: { name: 'my new app', url: 'http://nowhere.com' }
        expect(flash[:notice]).to eq('Your application was registered')
      end
      it 'saves registered application' do
        post :create, registered_application: { name: 'my new app', url: 'http://nowhere.com' }
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
          it { should redirect_to(registered_applications_path)}
        end
      end
    end
  end
end