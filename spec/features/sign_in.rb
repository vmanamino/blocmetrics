require 'rails_helper'

describe 'Sign in flow' do
  context 'successful sign in' do
    it 'welcomes user with root index view and indicates successful sign in' do
      user = create(:user)
      # go to root
      visit root_path
      # find sign in link
      within('.user-info') do
        click_link 'Sign In'
      end
      # enter info
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      within 'form' do
        click_button 'Sign in'
      end
      # check for signs of success
      within('.user-info') do
        expect(page).to have_content(user.email)
        expect(page).to have_content('Hello')
        find_link('Sign out').visible?
      end
      expect(current_path).to eq(root_path)
    end
  end
end