require 'acceptance/acceptance_helper'

feature 'Role editing', %q{
        In order to edit mistake
        As an authenticated user
        i'd like to be able to edit role
} do

  given (:user)   { create(:user) }
  given (:admin)  { create(:user, role_sid: 'admin') }
  given!(:role)   { create(:role) }

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

    scenario 'cannot edit role' do
      click_on 'Edit'
        expect(page).to have_content 'Action prohibited!'
      end
  end

  describe 'Un-authorised user ' do
    scenario 'cannot edit role' do
      visit role_path(role)
      expect(page).to_not have_link 'Edit'
    end
  end



end