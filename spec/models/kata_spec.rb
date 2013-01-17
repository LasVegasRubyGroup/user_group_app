require 'spec_helper'

describe Kata, :focus do

  describe '#votes' do
    
    context 'when there are no prior meetings' do
      
      let(:meeting) do
        Meeting.prototype.tap(&:save)
      end

      let(:topic_1) do
        create(:topic).tap do |topic|
          topic.stub(:votes).and_return(20)
        end
      end

      let(:topic_2) do
        create(:topic).tap do |topic|
          topic.stub(:votes).and_return(10)
        end
      end    

      subject(:kata) do
        create(:kata)
      end

      before do
        meeting.time_slots[0].topic_id = topic_1._id
        meeting.time_slots[1].topic_id = topic_2._id
        meeting.time_slots[2].topic_id = kata._id
        meeting.save
        p meeting
        kata.reload
      end

      it 'returns the average of the other two topics' do
        kata.votes.should eq 15
      end
    end
  end
end
