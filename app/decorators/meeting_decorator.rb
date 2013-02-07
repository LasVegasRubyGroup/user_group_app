class MeetingDecorator < Draper::Base
  decorates :meeting

  def kudo_buttons(user)
    if in_session? && kudos_available?(user)
      topics.map { |topic|
        h.link_to(topic.title, '#', data: { url: h.give_kudo_topic_path(topic) })
      }.join(' ').html_safe
    end 
  end

end