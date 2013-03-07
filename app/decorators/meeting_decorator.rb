class MeetingDecorator < Draper::Base
  decorates :meeting

  def kudo_buttons(user)
    if in_session? && kudos_available?(user)
      ("<h2>Give Kudos To Your Favorite Presentation</h2>" +
      topics.map { |topic|
        h.link_to(topic.title, '#', data: { url: h.give_kudo_topic_path(topic) }, class: 'btn btn-primary btn-kudo')
      }.join('<br>') + "<hr>").html_safe
    end 
  end

end