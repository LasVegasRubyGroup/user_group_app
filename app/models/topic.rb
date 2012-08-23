class Topic
  include Mongoid::Document

  field :title, type: String
  field :description, type: String

  has_one :time_slot
  belongs_to :user
  embeds_many :voters
  embeds_many :volunteers
  #bob was right (for once!)

end
