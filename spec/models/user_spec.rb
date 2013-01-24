require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.build(:user) }
  subject { user }

  describe '#vote_on!' do
    let(:user) { FactoryGirl.create(:user) }
    let(:topic) { FactoryGirl.create(:topic) }

    it 'votes for the provided topic' do
      expect { user.vote_on!(topic) }.to change(topic, :votes).by(1)
    end

    it 'returns true when successful' do
      user.vote_on!(topic).should be_true
    end

    context 'a duplicate vote' do
      before(:each) do
        user.vote_on!(topic)
      end

      it 'does not vote for the topic' do
        expect { user.vote_on!(topic) }.to_not change(topic, :votes)
      end

      it 'returns false' do
        user.vote_on!(topic).should be_false
      end
    end
  end

  describe '#volunteer_for!' do
    let(:user) { FactoryGirl.create(:user) }
    let(:topic) { FactoryGirl.create(:topic) }

    it 'volunteers for the provided topic' do
      expect { user.volunteer_for!(topic) }.to change { topic.volunteers.count }.by(1)
    end

    it 'returns true when successful' do
      user.volunteer_for!(topic).should be_true
    end

    context 'a duplicate volunteer' do
      before(:each) do
        user.volunteer_for!(topic)
      end

      it 'does not volunteer for the provided topic' do
        expect { user.volunteer_for!(topic) }.to_not change { topic.volunteers.count }
      end

      it 'returns false' do
        user.volunteer_for!(topic).should be_false
      end
    end
  end

  describe '#earn_points!' do
    subject(:user) { create(:user) }

    specify { expect { user.earn_points!(4) }.to change { user.points }.by(4) }
    specify { expect { user.earn_points!(10) }.to change { user.points }.by(10) }
  end

end
