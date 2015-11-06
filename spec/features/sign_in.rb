require 'rails_helper'

describe 'Sign in flow' do
  before do
    @user = create(:user)
  end
  context 'successful sign in' do
    it 'welcomes user with root index view and indicates successful sign in' do
      # go to root
      visit root_path
      # find sign in link
      within('.user-info') do
        click_link 'Sign In'
      end
      # enter info
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      within 'form' do
        click_button 'Sign in'
      end
      # check for signs of success
      within('.user-info') do
        expect(page).to have_content(@user.email)
        expect(page).to have_content('Hello')
        find_link('Sign out').visible?
      end
      expect(current_path).to eq(registered_applications_path)
    end
  end
  context 'failed sign in' do
    context 'Invalid email' do
      it 'returns to root index view, indicates error and provides Sign in option' do
        visit root_path
        within('.user-info') do
          click_link 'Sign In'
        end
        fill_in 'Email', with: 'louderthanthesky'
        fill_in 'Password', with: @user.password
        within 'form' do
          click_button 'Sign in'
        end
        within('.container') do
          expect(page).to have_content('Invalid email or password.')
        end
        within('.user-info') do
          find_link('Sign In').visible?
        end
        expect(current_path).to eq(new_user_session_path)
      end
    end
    context 'Invalid Password' do
      it 'returns to root index view, indicates error and provides Sign in option' do
        visit root_path
        within('.user-info') do
          click_link 'Sign In'
        end
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: 'isnothing'
        within 'form' do
          click_button 'Sign in'
        end
        within('.container') do
          expect(page).to have_content('Invalid email or password.')
        end
        within('.user-info') do
          find_link('Sign In').visible?
        end
        expect(current_path).to eq(new_user_session_path)
      end
    end
  end
end
