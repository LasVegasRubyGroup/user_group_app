require 'spec_helper'

describe Kata do

  describe '#votes' do

    let(:presenter) do
      create(:user)
    end

    subject(:kata) do
      create(:kata)
    end

     let(:meeting) do
      Meeting.prototype.tap do |meeting|
        meeting.time_slots.each do |time_slot|
          time_slot.presenter_id = presenter.id
        end
      end
    end

    let(:topic_1) do
      create(:topic_with_votes, votes_count: 20)
    end

    let(:topic_2) do
      create(:topic_with_votes, votes_count: 10)
    end

    before do
      meeting.time_slots[0].topic_id = topic_1._id
      meeting.time_slots[1].topic_id = topic_2._id
      meeting.time_slots[2].topic_id = kata._id
      meeting.save
      kata.reload
    end

  context 'when there are no prior meetings' do

      it 'returns the average of the other two topics' do
        expect(kata.votes).to eq(15)
      end
    end

    context 'when there are prior meetings' do

      let!(:previous_meetings) do
        3.times.collect do |i|
          Meeting.prototype.tap do |meeting|
            meeting.time_slots.each do |time_slot|
              time_slot.presenter_id = presenter.id
              time_slot.topic_id = send(:"topics_#{i}").pop.id
            end
            meeting.status = 'closed'
            meeting.save
          end
        end
      end

      let(:topics_0) do
        create_list(:topic_with_votes, 3, votes_count: 5)
      end

      let(:topics_1) do
        create_list(:topic_with_votes, 3, votes_count: 10)
      end

      let(:topics_2) do
        create_list(:topic_with_votes, 3, votes_count: 9)
      end

      it 'returns the average of all of the topics' do
        expect(kata.votes).to eq(9)
      end
    end
  end
end
