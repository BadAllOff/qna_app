require 'spec_helper'

RSpec.describe Attachment, type: :model do
  it { should belong_to :question }
end
