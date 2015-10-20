# require 'rails_helper'
#
# RSpec.describe "roles/edit", type: :view do
#   before(:each) do
#     @role = assign(:role, Role.create!(
#       :role_sid => "MyString",
#       :role_title => "MyString",
#       :role_description => "MyString"
#     ))
#   end
#
#   it "renders the edit role form" do
#     render
#
#     assert_select "form[action=?][method=?]", role_path(@role), "post" do
#
#       assert_select "input#role_role_sid[name=?]", "role[role_sid]"
#
#       assert_select "input#role_role_title[name=?]", "role[role_title]"
#
#       assert_select "input#role_role_description[name=?]", "role[role_description]"
#     end
#   end
# end
