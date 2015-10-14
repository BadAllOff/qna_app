require 'rails_helper'

feature "User answer", %q{
        In order to answer the question from user
        As an authenticated user
        I want be able to answer the questions
  } do

  given(:user) {create(:user)}
  given(:question) {create(:question)}

  scenario 'Authenticated user creates answer' do
    sign_in(user)

    visit question_path(question)

    fill_in 'Your answer', with: 'My Answer'
    click_on 'Create'

    expect(current_path).to eq question_path(question)
    within '.answers' do # Поределить блок с селектором CSS в котором ответы
      expect(page).to have_content 'My Answer' # Контент который мы ввели
    end
  end

  scenario 'Non-authenticated user creates answer' do

  end

end