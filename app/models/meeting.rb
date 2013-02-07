class Meeting
  include Mongoid::Document
  field :date, type: Date
  field :status, type: String, default: 'open'

  scope :open, where(status: 'open')
  scope :closed, where(status: 'closed')
  scope :archived, where(status: 'archived')


  embeds_many :time_slots
  accepts_nested_attributes_for :time_slots
 
  START_AT = 19.freeze
  END_AT = 21.freeze

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
    # mark_topics_closed
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

  def archived?
    status == 'closed'
  end

  def in_session?
    Date.current == date && Time.zone.now.hour >= START_AT && Time.zone.now.hour <= END_AT
  end

  def mark_topics_selected
    topics.each { |topic| topic.update_attribute(:status, 'selected') }
  end

  def available_for_kudos?
    open? && in_session?
  end

  def kudos_available?(user)
    topics.all? do |topic|
      topic.can_add_kudo?(user)
    end
  end

  private

  def self.by_date
    self.open.sort_by { |t| t.date }.reverse
  end

  def give_points
    time_slots.map do |time_slot|
      time_slot.give_points
    end
  end

  def mark_topics_closed
    topics.each { |topic| topic.update_attribute(:status, 'closed') }
  end


end
