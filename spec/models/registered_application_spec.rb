require 'rails_helper'

describe RegisteredApplication do
  it { should belong_to(:user) }
  it { should have_many(:events).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:url) }
  it { should validate_uniqueness_of(:url) }
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

  describe '.count_events' do
    before do
      @other_events = create_list(:event, 3, name: 'my event')
      @registered_application = create(:registered_application)
      @events = create_list(:event, 2, name: 'my event', registered_application: @registered_application)
      @events.push(create_list(:event, 2, name: 'my other event', registered_application: @registered_application))
      @events.push(create(:event, name: 'yet another event', registered_application: @registered_application))
    end
    it 'collects only events belonging to registered application' do
      all_events = Event.all
      expect(all_events.count).to eq(8)
      specific_events = @registered_application.count_events
      count = 0
      specific_events.each do |_key, value|
        count += value
      end
      expect(count).to eq(5)
    end
    it 'provides a count for all events belonging to a registered application' do
      each_event = @registered_application.count_events
      expect(each_event['my event']).to eq(2)
      expect(each_event['my other event']).to eq(2)
      expect(each_event['yet another event']).to eq(1)
    end
  end
end
