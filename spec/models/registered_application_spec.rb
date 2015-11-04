require 'rails_helper'

describe RegisteredApplication do
  it { should belong_to(:user) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:url) }
  describe '.visible_to' do
    before do
      @user = create(:user)
      @apps_user = create_list(:registered_application, 5, user: @user)
      @apps_other = create_list(:registered_application, 5)
    end
    it 'collects registered applications belonging to user' do
      apps = RegisteredApplication.visible_to(@user)
      apps.each do |app|
        expect(app.user.id).to eq(@user.id)
      end
      expect(apps.length).to eq(5)
    end
  end
end