require 'spec_helper'

describe TimeSlot do
  describe '#give_points' do
    # let(:meeting) { build(:meeting, time_slots: [time_slot]) }
    subject(:time_slot) { build(:time_slot, topic_id: topic._id) }

    context "when the topic has 4 points" do
      let(:topic) { create(:topic_with_votes, votes_count: 4) }

      before do
        time_slot.presenter.should_receive(:points=)
        time_slot.give_points
      end

      specify { time_slot.topic.user.points.should == 1 }
      specify { time_slot.presenter.points.should == 3 }
    end

  end

end
