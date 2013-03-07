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

  def presenter
    @presenter ||= User.find(presenter_id)
  end

  def give_points
    topic.give_points_to(presenter)
  end

  def to_csv
    "#{starts_at},#{ends_at},#{topic_id},#{presenter.name},#{meeting._id}"
  end

  def presenter_points
    points - suggestion_points
  end

  def points
    topic.votes
  end

  delegate :give_kudo_as, to: :topic
end
