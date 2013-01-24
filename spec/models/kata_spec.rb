require 'spec_helper'

describe Kata do

  describe '#votes' do

    context 'when there are no prior meetings' do

      let(:meeting) do
        Meeting.prototype.tap do |meeting|
          meeting.time_slots.each do |time_slot|
            time_slot.presenter_id = presenter.id
          end
        end
      end

      let(:presenter) do
        create(:user)
      end

      let(:topic_1) do
        create(:topic_with_votes, votes_count: 20)
      end

      let(:topic_2) do
        create(:topic_with_votes, votes_count: 10)
      end

      subject(:kata) do
        create(:kata)
      end

      before do
        meeting.time_slots[0].topic_id = topic_1._id
        meeting.time_slots[1].topic_id = topic_2._id
        meeting.time_slots[2].topic_id = kata._id
        meeting.save
        kata.reload
      end

      it 'returns the average of the other two topics' do
        expect(kata.votes).to eq(15)
      end
    end
  end
end
