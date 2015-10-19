require 'rails_helper'

RSpec.describe "roles/index", type: :view do
  before(:each) do
    assign(:roles, [
      Role.create!(
        :role_sid => "Role Sid",
        :role_title => "Role Title",
        :role_description => "Role Description"
      ),
      Role.create!(
        :role_sid => "Role Sid",
        :role_title => "Role Title",
        :role_description => "Role Description"
      )
    ])
  end

  it "renders a list of roles" do
    render
    assert_select "tr>td", :text => "Role Sid".to_s, :count => 2
    assert_select "tr>td", :text => "Role Title".to_s, :count => 2
    assert_select "tr>td", :text => "Role Description".to_s, :count => 2
  end
end
