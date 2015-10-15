require_relative 'acceptance_helper'

feature "User answer", %q{
        In order to answer the question from user
        As an authenticated user
        I want be able to answer the questions
  } do

  given(:user) {create(:user)}
  given!(:question) {create(:question)}
  # Что бы данные РЕАЛЬНО записывались в бд внесите изменения в rails_helper
  #config.use_transactional_fixtures = FALSE

  scenario 'Authenticated user creates answer', js: true do
    sign_in(user)

    visit question_path(question)

    fill_in 'Your answer', with: 'My Answer'
    click_on 'Create'

    expect(current_path).to eq question_path(question)
    within '.answers' do # Поределить блок с селектором CSS в котором ответы
      expect(page).to have_content 'My Answer' # Контент который мы ввели
    end
  end

  scenario 'User try to create invalid answer', js: true do
    sign_in user
    visit question_path(question)

    click_on 'Create'

    expect(page).to have_content "Body can't be blank"
  end

end