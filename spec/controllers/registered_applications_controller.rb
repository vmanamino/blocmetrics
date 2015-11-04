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
      it 'denies app not belonging to user' do
        @apps_other.each do |app|
          get :show, id: app.id
          app_shown = assigns(:registered_application)
          @apps_user.each do |user_app|
            expect(app).not_to eq(user_app)
          end
          expect(app_shown.user).not_to eq(@user)
        end
      end
    end
  end
end