require 'spec_helper'

describe 'Create a meeting' do
  let(:topics) { create_list :topic, 3 }
  let(:presenter_one) { create :user }

  before do
  end

  context 'when creating a meeting', :signed_in do

    context 'as an organizer' do

      it 'creates a meeting' do
        user.organizer = true
        visit '/meetings/new'
      end

      it 'should require a meeting organizer' do
        user.organizer = true
        visit '/meetings/new'
        page.should have_content('New Meetings')
      end
    end

    context 'as a regular member' do
      it 'redirects you to the the home page' do
        user.organizer = false
        visit '/meetings/new'
        page.should have_content('You need to be a meeting organizer to do that')
      end
    end
  end

  context 'when not signed in' do
    it 'redirects to the sign-in page' do
      visit '/meetings/new'
      expect(current_path).to eq new_user_session_path
    end
  end

end
