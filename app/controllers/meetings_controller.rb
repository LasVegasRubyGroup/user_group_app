class MeetingsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :require_organizer, except: [:index, :show]
  before_filter :load_topics, only: [:new, :create]

  def new
    @meeting = Meeting.prototype
  end

  def create
    @meeting = Meeting.new(params[:meeting])

    if @meeting.save
      redirect_to @meeting, notice: 'All set!'
    else
      render 'new', flash: { error: 'No luck!' }
    end
  end

  def show
    @meeting = Meeting.find(params[:id])
  end

  private

  def load_topics
    @topics = TopicDecorator.all
  end

end
