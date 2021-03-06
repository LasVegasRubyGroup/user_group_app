require 'spec_helper'

describe Meeting do
  let(:topics) { create_list(:topic, 3) }  
  let(:presenters) { create_list(:user, 3) }  
  let(:meeting) { Meeting.prototype }

  before do
    meeting.time_slots.zip(topics, presenters) do |time_slot, topic, presenter|
      time_slot.topic_id = topic._id
      time_slot.presenter_id = presenter._id
    end
  end

  context 'when finalizing a meeting' do
    it 'meeting was saved' do
      meeting.save
      expect(Meeting.all).to have(1).meeting
    end


  end

  describe '#has_kudoed?' do

    let(:meeting) do
      create(:meeting)
    end

    context 'when the provided user has not kudoed any topics' do

      it 'returns false' do
        pending
      end
    end

    context 'when the provided user has kudoed a topic' do

      it 'returns true' do
        pending
      end
    end
  end
end
