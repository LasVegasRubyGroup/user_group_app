class Topic
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String
  field :status, type: String, default: 'open'
  field :meeting_id, type: Moped::BSON::ObjectId

  # has_one :time_slot
  belongs_to :user
  embeds_many :voters
  embeds_many :volunteers

  validates :title, presence: true
  validates :description, presence: true

  scope :open, where(status: 'open')
  scope :archived, where(status: 'archived')
  scope :selected, where(status: 'selected')


  def self.column_names
    self.fields.collect { |field| field[0] }
  end

  def self.to_csv(options = {})
    CSV.generate(force_quotes: true) do |csv|
      csv << column_names + ['Voter Ids', 'Volunteer Ids', 'Created by']
      all.each do |topic|
        csv << topic.attributes.values_at(*column_names) + [topic.voters.collect(&:to_csv).join(',')] + [topic.volunteers.collect(&:to_csv).join(',')] + [topic.user.name]
      end
    end
  end


  def give_points_to(presenter)
    [
      { name: user.name, points: user.earn_points!(suggestion_points) },
      { name: presenter.name, points: presenter.earn_points!(presenter_points)}
    ]
  end

  def user_name
    if user
      user.name
    else
      'lvrug'
    end
  end

  def self.open_by_votes
    self.open.sort_by { |t| t.votes }.reverse
  end

  def self.by_most_recent
    self.desc(:created_at)
  end

  def votes
    voters.size
  end

  def meeting
    @meeting ||= Meeting.find(meeting_id) if meeting_id
  end 

  def archived?
    status == 'archived'
  end 

  def open?
    status == 'open'
  end

  def selected?
    status == 'selected'
  end

  def volunteer_names
    volunteers.collect { |volunteer| volunteer.name }
  end

  def suggestion_points
    points/4
  end

  def presenter_points
    points - suggestion_points
  end

  def points
    votes
  end

end
