require 'rails_helper'
require 'helpers/users'

describe 'User' do
  context 'not Signed Up' do
    it 'can Sign Up' do
      visit '/'
      click_link 'Sign Up'
      fill_in 'Email', with: 'eric@hrc.com'
      fill_in 'Password', with: 'testtest'
      fill_in 'Password confirmation', with: 'testtest'
      click_button 'Sign up'
      expect(page).to have_content 'Welcome, eric@hrc.com'
      expect(current_path).to eq '/'
    end
  end

  context 'is Signed Up' do
    before do
      sign_up
    end

    it 'can Sign In' do
      visit '/'
      click_link 'Sign In'
      fill_in 'Email', with: 'pete@hrc.com'
      fill_in 'Password', with: 'testtest'
      click_button 'Log in'
      expect(page).to have_content 'Welcome, pete@hrc.com'
      expect(current_path).to eq '/'
    end
  end

end