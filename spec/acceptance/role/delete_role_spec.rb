require 'acceptance/acceptance_helper'

feature "Delete Role", %q{
        Only user can remove the role
  } do

  given (:user)   { create(:user) }
  given (:admin)  { create(:user, role_sid: 'admin') }
  given!(:role)   { create(:role) }

  scenario 'Admin delete role' do
    sign_in(admin)

    visit role_path(role)
    click_on 'Delete'

    expect(page).to have_content 'Role was successfully destroyed.'
    expect(page).to_not have_content 'Valid Role title'
    expect(current_path).to eq roles_path
  end

  scenario 'Authenticated user cannot delete role' do
    sign_in(user)

    visit role_path(role)
    click_on 'Delete'

    expect(page).to have_content 'Action prohibited!'
    expect(current_path).to eq root_path
  end

  scenario 'Non-authenticated user cannot delete role' do
    visit role_path(role)
    expect(page).to_not have_link 'Delete'
  end
end