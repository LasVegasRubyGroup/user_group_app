class UserDecorator < Draper::Base
  decorates :user

  def signed_in?
    !user.new_record?
  end

  def registration_link
    unless signed_in?
      h.link_to "Sign Up", h.new_user_registration_path
    end
  end

  def session_control
    if signed_in?
      h.link_to "Sign Out", h.destroy_user_session_path, method: :delete
    else
      h.link_to "Sign In", h.new_user_session_path
    end
  end
  
  def new_topic_link 
    if signed_in?
      h.link_to 'New Topic', h.new_topic_path
    end
  end

  def edit_topic_link(topic)
    if (topic.user_id == user._id) or user.organizer
      h.link_to 'Edit', h.edit_topic_path(topic)
    end
  end

  def destroy_topic_link(topic)
    if topic.user_id == user._id
      h.link_to 'Destroy', topic, :confirm => 'Are you sure?', :method => :delete
    end
  end

  def vote_link(topic)
    if signed_in? and !voted_on?(topic)
      h.link_to 'Vote', h.vote_topic_path(topic), method: :put
    end
  end

end
