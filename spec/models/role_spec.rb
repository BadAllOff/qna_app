require 'rails_helper'

RSpec.describe Role, type: :model do
  it { should validate_presence_of :role_sid }
  it { should validate_presence_of :role_title }
  it { should validate_presence_of :role_description }
end
