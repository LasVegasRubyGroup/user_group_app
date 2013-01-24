class Topic
  include Mongoid::Document

  field :title, type: String
  field :description, type: String
  field :status, type: String, default: 'open'
  field :kudos, type: Array, default: []

  # has_one :time_slot
  belongs_to :user
  embeds_many :voters
  embeds_many :volunteers

  validates :title, presence: true
  validates :description, presence: true

  scope :open, where(status: 'open')
  scope :archived, where(status: 'archived')
  scope :selected, where(status: 'selected')

  def self.by_votes
    self.open.sort_by { |t| t.votes }.reverse
  end

  def votes
    voters.size
  end

  def volunteer_names
    volunteers.collect { |volunteer| volunteer.name }
  end

  def give_kudo_as(user)
    return if kudos.include?(user.id)

    kudos << user.id
    save
  end
end
