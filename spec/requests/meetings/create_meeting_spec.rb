require 'spec_helper'

describe 'Create a meeting' do

  context 'when not signed in' do
    it 'redirects to the sign-in page' do
      visit '/meetings/new'
      expect(current_path).to eq new_user_session_path
    end
  end
end
