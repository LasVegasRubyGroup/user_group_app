class Topic
  include Mongoid::Document

  field :title, type: String
  field :description, type: String
  field :status, type: String, default: 'open'

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

end
