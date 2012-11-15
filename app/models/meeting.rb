class Meeting
  include Mongoid::Document
  after_create :give_points
  field :date, type: Date

  embeds_many :time_slots
  accepts_nested_attributes_for :time_slots

  def self.prototype
    self.new(
      date: Date.today + 2.weeks,
      time_slots_attributes: [
        { starts_at: '6:20 PM', ends_at: '6:50 PM' },
        { starts_at: '6:50 PM', ends_at: '7:20 PM' },
        { starts_at: '7:20 PM', ends_at: '7:50 PM' }
      ]
    )
  end

private

  def give_points
    time_slots.each do |time_slot|
      time_slot.give_points
    end
  end

end
