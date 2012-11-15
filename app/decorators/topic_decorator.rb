class TopicDecorator < Draper::Base
  decorates :topic

  def link
    h.link_to topic.title, topic
  end

  def volunteer_data
    topic.volunteers.map { |v| { id: v.user_id, name: v.name } }.to_json
  end

  def description
    h.markdown.render(topic.description).html_safe
  end
end