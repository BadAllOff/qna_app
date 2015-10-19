class Role < ActiveRecord::Base
  validates_presence_of :role_sid, :role_title, :role_description
  validates :role_sid, uniqueness: true, format: { with: /\A[a-z]+\z/}
end
