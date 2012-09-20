class MeetingsController < ApplicationController

  def new
    @topics = Topic.all
    @meeting = Meeting.prototype
  end


end
