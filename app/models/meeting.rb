class Meeting
  include Mongoid::Document

  field :date, type: Date

  embeds_many :time_slots
end
