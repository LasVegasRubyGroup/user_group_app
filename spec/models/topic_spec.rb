require 'spec_helper'

describe Topic do

  describe '#presenter_points' do
    subject(:topic) { build(:topic) }

    context 'with no kudos' do
      context 'with 10 total points and 3 suggestion points' do
        before do
          topic.stub(:points).and_return(10)
          topic.stub(:suggestion_points).and_return(3)
        end

        specify { topic.presenter_points.should == 7 }
      end

      context 'with 8 total points and 2 suggestion points' do
        before do
          topic.stub(:points).and_return(8)
          topic.stub(:suggestion_points).and_return(2)
        end

        specify { topic.presenter_points.should == 6 }
      end
    end

    context 'with 3 kudos' do
      before { topic.kudos = ['user1','user2','user3'] }

      context 'with 10 total points and 3 suggestion points' do
        before do
          topic.stub(:points).and_return(10)
          topic.stub(:suggestion_points).and_return(3)
        end

        specify { topic.presenter_points.should == 10 }
      end

      context 'with 8 total points and 2 suggestion points' do
        before do
          topic.stub(:points).and_return(8)
          topic.stub(:suggestion_points).and_return(2)
        end

        specify { topic.presenter_points.should == 9 }
      end
    end
  end

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
