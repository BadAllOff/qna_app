require 'acceptance/acceptance_helper'

feature 'Answer editing', %q{
        In order to edit mistake
        As an author of answer
        i'd like to be able to edit my answer
} do

  given(:user) {create(:user)}
  given!(:question) {create(:question)}
  given!(:answer) {create(:answer, question: question)}

  scenario 'Un-authorised user try to edit answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end

  describe 'Authenticated user' do
    before do
      sign_in user
      visit question_path(question)
    end

    scenario 'sees link to Edit' do
      within '.answers' do
        expect(page).to have_link 'Edit'
      end
    end

    scenario "don't sees link to Edit other users answer" do
      # TODO ДЗ Думаю использовать cancancan
    end
    scenario 'try to edit his answer', js: true do
      click_on 'Edit'

      within '.answers' do
        fill_in 'Answer', with: 'edited answer'
        click_on 'Update'
        expect(page).to_not have_content answer.body
        expect(page).to have_content 'edited answer'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario "try to edit other user's answer" do
      # TODO ДЗ Думаю использовать cancancan
    end

    scenario "try to edit other user's answer as admin" do
      # TODO ДЗ Думаю использовать cancancan
    end
  end

end