require 'spec_helper'

describe 'Get topics' do

  let!(:topics) { create_list :topic, 3 }

  it 'lists the topics' do

    visit '/topics'

    expect(page.status_code).to eq 200

    topics.each do |topic|
      expect(page).to have_content(topic.title)
    end
  end
end
