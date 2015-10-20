require 'acceptance/acceptance_helper'

feature 'Role editing', %q{
        In order to edit mistake
        As an authenticated user
        i'd like to be able to edit role
} do

  given(:user) {create(:user)}
  given!(:role) {create(:role)}

  scenario 'Un-authorised user try to edit role' do
    visit role_path(role)

    expect(page).to_not have_link 'Edit'
  end

  describe 'Authenticated user' do
    before do
      sign_in user
      visit role_path(role)
    end

    scenario 'sees link to Edit' do
      within '.btn-group' do
        expect(page).to have_link 'Edit'
      end
    end

    scenario 'try to edit role' do
      click_on 'Edit'
        fill_in 'Role sid', with: 'testrole'
        fill_in 'Role title', with: 'Role title'
        fill_in 'Role description', with: 'Role description'
        click_on 'Update Role'
        expect(page).to_not have_content role.role_sid
        expect(page).to have_content 'Role was successfully updated.'
      end
    end

end