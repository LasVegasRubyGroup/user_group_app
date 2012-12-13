class Meeting
  include Mongoid::Document
  field :date, type: Date
  field :status, type: String, default: 'open'

  scope :open, where(status: 'open')
  scope :closed, where(status: 'closed')

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

  def finalize
    update_attribute(:status, 'closed')
    give_points
    archive_topics
  end

  def topics
    @topics ||= time_slots.map(&:topic)
  end

  def open?
    status == 'open'
  end

  def closed?
    status == 'closed'
  end

  private

  # def archive_topics
  #   topics.each { |topic| topic.archived }
  # end

  def give_points
    time_slots.map do |time_slot|
      time_slot.give_points
    end
  end

end
