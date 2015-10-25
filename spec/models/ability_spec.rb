require 'rails_helper'

describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'for gest' do
    let(:user) { nil }

    it { should be_able_to :read, Question }
    it { should be_able_to :read, Answer }

    it { should_not be_able_to :manage, :all }
  end

  describe 'for admin' do
    let(:user) { create :user, role_sid: 'admin' }

    it { should be_able_to :manage, :all }
  end

  describe 'for vizitor' do
    let(:user) { create :user, role_sid: 'vizitor' }
    let(:another_user) { create(:user) }

    it { should_not be_able_to :manage, :all }

    it { should be_able_to :create, Question }
    it { should be_able_to :create, Answer }

  end


end
