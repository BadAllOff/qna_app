# require 'rails_helper'
#
# RSpec.describe "roles/new", type: :view do
#   before(:each) do
#     assign(:role, Role.new(
#       :role_sid => "MyString",
#       :role_title => "MyString",
#       :role_description => "MyString"
#     ))
#   end
#
#   it "renders new role form" do
#     render
#
#     assert_select "form[action=?][method=?]", roles_path, "post" do
#
#       assert_select "input#role_role_sid[name=?]", "role[role_sid]"
#
#       assert_select "input#role_role_title[name=?]", "role[role_title]"
#
#       assert_select "input#role_role_description[name=?]", "role[role_description]"
#     end
#   end
# end
