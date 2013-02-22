require 'spec_helper'

describe TimeSlot do
  describe '#give_points' do
    let(:meeting) { Meeting.prototype }
    subject(:time_slot) { meeting.time_slots.first }

    context "when the topic has 4 points" do
      let(:topic) { create(:topic_with_votes, votes_count: 4) }

      before do
        time_slot.topic_id = topic.id
        time_slot.presenter_id = create(:user).id
        meeting.save
      end

      it "gives the topic suggester 1 point" do
        time_slot.give_points
        time_slot.topic.user.points.should == 1
      end

      it "gives the topic presenter 3 point" do
        time_slot.give_points
        time_slot.presenter.points.should == 3
      end
    end

  end

end
