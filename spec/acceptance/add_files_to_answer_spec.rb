require_relative 'acceptance_helper'

feature 'Add files to answers', %q{
        In order to illustrate my answers
        As an answers author
        i'd like to be able to attach files
                               } do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  # TODO implement ability to add multiple files
  scenario 'User adds file when writes answers', js: true do
    fill_in 'Your answer', with: 'My Answer'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'

    expect(current_path).to eq question_path(question)
    within '.answers' do # Поределить блок с селектором CSS в котором ответы
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    end
  end


end