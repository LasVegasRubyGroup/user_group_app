class TimeSlot
  include Mongoid::Document

  field :starts_at, type: Time
  field :ends_at, type: Time

  embedded_in :meeting
  belongs_to :topic
  belongs_to :presentor, class_name: "User"
end
