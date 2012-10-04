class Meeting
  include Mongoid::Document

  field :date, type: Date

  embeds_many :time_slots
  accepts_nested_attributes_for :time_slots

  def self.prototype
    self.new(
      date: Date.today + 2.weeks,
      time_slots_attributes: [
        { starts_at: Time.parse('6:20p'), ends_at: Time.parse('6:50p') },
        { starts_at: Time.parse('6:50p'), ends_at: Time.parse('7:20p') },
        { starts_at: Time.parse('7:20p'), ends_at: Time.parse('7:50p') }
      ]
    )
  end

end
