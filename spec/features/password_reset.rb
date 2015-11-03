## This requires the host URL
require 'rails_helper'
# this is the test/development environment url
Rails.application.routes.default_url_options[:host] = 'http://philter-108461.nitrousapp.com:3000'

describe 'Password Reset' do
  before do
    @user = create(:user)
  end
  it 'provides confirmation email sent to reset password' do
    visit root_path
    within('.user-info') do
      click_link('Sign In')
    end
    within('.container') do
      click_link('Forgot your password?')
    end
    fill_in 'Email', with: @user.email
    within 'form' do
      click_button 'Send me reset password instructions'
    end
    within('.container') do
      expect(page).to have_content('You will receive an email with instructions on how to reset your password in a few minutes.') # rubocop:disable Metrics/LineLength
    end
  end
end
