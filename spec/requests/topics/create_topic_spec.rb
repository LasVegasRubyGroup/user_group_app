require 'spec_helper'

describe 'Create a topic', :focus do

  context 'when signed in', :signed_in do

    it 'creates a topic' do

      visit '/topics/new'
      fill_in 'topic_title', with: 'When to use parens'
      fill_in 'topic_description', with: 'How to be pedantic about parens'
      click_button 'Create Topic'

      expect(page.status_code).to eq 200

      expect(Topic.count).to be 1
      topic = Topic.first

      expect(topic.title).to eq 'When to use parens'
      expect(topic.description).to eq 'How to be pedantic about parens'
    end
  end

  context 'when not signed in' do
    it 'redirects to the sign-in page' do
      visit '/topics/new'
      expect(current_path).to eq new_user_session_path
    end
  end
end
