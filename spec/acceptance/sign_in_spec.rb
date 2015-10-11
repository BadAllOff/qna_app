require 'rails_helper'
# %q - модификатор для многострочного кода
feature 'User sign in', %q{
  In order to be able to ask question
  As an user
  I want to be able to sign in
} do

  scenario 'Registered user try to sign in' do
    User.create(email: 'user@test.com', password: 'password')

    visit new_user_session_path
    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password',with: 'password'
    #save_and_open_page # Сохранит и выведет страницу для просмотра. Гем launchy

    click_on 'Log in'

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Non-registered user try to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Password',with: 'password'
    click_on 'Log in'

    expect(page).to have_content "Invalid email or password"
    expect(current_path).to eq new_user_session_path
  end
end