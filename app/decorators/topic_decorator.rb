class TopicDecorator < Draper::Base
  decorates :topic

  def link
    h.link_to topic.title, topic
  end

end
