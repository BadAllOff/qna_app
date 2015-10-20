require 'acceptance/acceptance_helper'

feature "Create Role", %q{
        In order to create and set roles
        As an authenticated user
        I want be able to create roles
  } do

  given(:user) {create(:user)}

  scenario 'Authenticated user creates role' do

    sign_in(user)

    visit roles_path
    click_on 'New Role'
    fill_in 'Role sid', with: 'testrole'
    fill_in 'Role title', with: 'Role title'
    fill_in 'Role description', with: 'Role description'
    click_on 'Create Role'

    expect(page).to have_content 'Role was successfully created.'
  end

  scenario 'Non-authenticated user creates question' do
    visit roles_path
    click_on 'New Role'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end


end