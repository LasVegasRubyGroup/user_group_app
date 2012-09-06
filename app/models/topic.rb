class Topic
  include Mongoid::Document

  field :title, type: String
  field :description, type: String

  has_one :time_slot
  belongs_to :user
  belongs_to :presentor, class_name: "User", inverse_of: :presentations
  embeds_many :voters
  embeds_many :volunteers

  def self.by_votes
    self.all.sort_by { |t| t.votes }.reverse
  end

  def votes
    voters.size
  end

end
