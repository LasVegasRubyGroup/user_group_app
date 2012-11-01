class UserDecorator < Draper::Base
  decorates :user

  def signed_in?
    !user.new_record?
  end

  def registration_link
    unless signed_in?
      h.link_to "Sign Up", h.register_path
    end
  end

  def session_control
    if signed_in?
      h.link_to "Sign Out", h.sign_out_path, method: :delete
    else
      h.link_to "Sign In", h.sign_in_path
    end
  end
  
  def new_topic_link 
    if signed_in?
      h.link_to 'Suggest a presentation topic', h.new_topic_path, class: 'btn btn-primary'
    end
  end

  def edit_topic_link(topic)
    if (topic.user_id == user._id) or user.organizer
      h.link_to 'Edit', h.edit_topic_path(topic), class: 'btn btn-mini'
    end
  end

  def destroy_topic_link(topic)
    if topic.user_id == user._id
      h.link_to 'Destroy', topic, :confirm => 'Are you sure?', :method => :delete, class: 'btn btn-mini btn-danger'
    end
  end

  def vote_link(topic)
    if signed_in? 
      if !voted_on?(topic)
        #todo need a better way to do these <i> tag
        h.link_to "<i class='icon-thumbs-up'></i>Vote".html_safe, h.vote_topic_path(topic), method: :put, remote: true, class: 'btn btn-mini'
      else
        h.content_tag :span, "<i class='icon-ok icon-white'></i> Voted".html_safe, class: 'label label-success'
      end
    end
  end

  def volunteer_link(topic)
    if signed_in?
      if !volunteered_for?(topic)
        h.link_to "<i class='icon-star icon-white'></i> Volunteer".html_safe, h.volunteer_topic_path(topic), method: :put, remote: true, class: 'btn btn-warning btn-mini', confirm: "Are you sure you want to be a hero?"
      else
        h.content_tag :span, "<i class='icon-ok icon-white'></i>Volunteered".html_safe, class: 'label label-success'
      end
    end
  end


end
