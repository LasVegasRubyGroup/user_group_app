require 'spec_helper'

describe Meeting do

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
