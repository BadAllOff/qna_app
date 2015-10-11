require 'rails_helper'

feature "Create Question", %q{
        In order to get answer from community
        As an authenticated user
        I want be able to ask questions
  } do

  scenario 'Authenticated user creates question' do
    User.create(email: 'user@test.com', password: 'password')

    visit new_user_session_path
    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password',with: 'password'
    click_on 'Log in'

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'test question'
    fill_in 'Body', with: 'text text'
    click_on 'Create'

    expect(page).to have_content 'Your question successfully created.'
  end

  scenario 'Non-authenticated user creates question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end


end