require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content 'Register'
  end

  feature 'signing up a user' do
    before(:each) do
      visit new_user_url
      fill_in 'Email', with: 'testing_username'
      fill_in 'Password', with: 'biscuits'
      click_on 'Register'
    end

    scenario 'redirects to user page after signup' do
      expect(page).to have_content 'User page!'
    end

    scenario 'shows username on the user\'s page after signup' do
      expect(page).to have_content 'testing_username'
    end
  end

  
end
