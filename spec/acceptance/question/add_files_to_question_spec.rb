require 'acceptance/acceptance_helper'

feature 'Add files to question', %q{
        In order to illustrate my question
        As an question's author
        i'd like to be able to attach files
                               } do

  given(:user) {create(:user)}

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'User adds file when asks question' do
    fill_in 'Title', with: 'test question'
    fill_in 'Body', with: 'test text'
    attach_file 'File', "#{Rails.root}/spec/test_attachments/practice_makes_perfect.jpg"
    click_on 'Create'

    expect(page).to have_link 'Show file', href: '/uploads/attachment/file/1/practice_makes_perfect.jpg'
  end


end