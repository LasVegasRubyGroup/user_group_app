class TimeSlot
  include Mongoid::Document

  field :starts_at, type: String
  field :ends_at, type: String
  field :topic_id, type: Moped::BSON::ObjectId
  field :presenter_id, type: Moped::BSON::ObjectId

  embedded_in :meeting

  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validates :topic_id, presence: true
  validates :presenter_id, presence: true

  def topic
    @topic ||= Topic.find(topic_id)
  end

  # def topic_id=(value)
  #   topic = Topic.find(value)
  #   topic.meeting_id = meeting._id
  #   topic.save
  #   super
  # end

  def presenter
    @presenter ||= User.find(presenter_id)
  end

  def give_points
    topic.give_points_to(presenter)
  end



end
