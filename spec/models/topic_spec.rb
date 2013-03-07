require 'spec_helper'

describe Topic do

  describe '#give_kudo_as' do

    let(:current_user) do
      create(:user)
    end

    let(:topic) do
      create(:topic)
    end

    it 'adds increases the count of #kudos' do
      expect { topic.give_kudo_as(current_user) }.to change(topic.kudos, :count)
    end

    it 'adds the user identifier to the #kudos' do
      topic.give_kudo_as(current_user)
      expect(topic.kudos).to include(current_user.id)
    end

    it 'saves the record' do
      topic.should_receive(:save)
      topic.give_kudo_as(current_user)
    end

    context 'when the user has already given kudos' do

      before do
        topic.give_kudo_as(current_user)
      end

      it 'returns false' do
        expect(topic.give_kudo_as(current_user)).to be_false
      end

      it 'does not increase the count of #kudos' do
        expect { topic.give_kudo_as(current_user) }.to change(topic.kudos, :count).by(0)
      end

      it 'does not save the record' do
        topic.should_not_receive(:save)
        topic.give_kudo_as(current_user)
      end
    end
  end
end
