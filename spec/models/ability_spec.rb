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

  describe 'for user' do
    let(:user) { create :user, role_sid: 'user' }
    let(:another_user) { create(:user) }

    it { should_not be_able_to :manage, :all }

    it { should be_able_to :create, Question }
    it { should be_able_to :create, Answer }

    %w(question answer).each do |model|
      context "#{model.classify}" do
        let(:resource) { create(model.to_sym, user: user) }
        let(:another_resource) { create(model.to_sym, user: another_user) }

        it { should be_able_to :update, resource, user: user }
        it { should_not be_able_to :update, another_resource, user: user }

        it { should be_able_to :destroy, resource, user: user }
        it { should_not be_able_to :destroy, another_resource, user: user }

        context 'Attachment destroy' do
          let(:attachment) { create(:attachment, attachable: resource) }
          let(:another_attachment) { create(:attachment,  attachable: another_resource) }
          # TODO добавить методы позже
          # it { should be_able_to :destroy, attachment,  user: user }
          # it { should_not be_able_to :destroy, another_attachment,  user: user }
        end
      end
    end

  end


end
