require 'rails_helper'

feature "User answer", %q{
        In order to answer the question from user
        As an authenticated user
        I want be able to answer the questions
  } do

  given(:user) {create(:user)}
  given(:question) {create(:question)}

  scenario 'Authenticated user creates question' do
    sign_in(user)



    visit question_path(question)

    fill_in 'Your answer', with: 'Answer question'
    click_on 'Create'

    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_content 'Answer question'
    end
  end

  scenario 'Non-authenticated user creates question' do

  end

end