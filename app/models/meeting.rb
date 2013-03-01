class Meeting  
  include Mongoid::Document

  after_save :update_topics

  field :date, type: Date
  field :status, type: String, default: 'open'

  scope :open, where(status: 'open')
  scope :closed, where(status: 'closed')
  scope :archived, where(status: 'archived')

  embeds_many :time_slots
  accepts_nested_attributes_for :time_slots

  def self.column_names
    self.fields.collect { |field| field[0] }
  end

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

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names + ['time_slots']
      all.each do |meeting|
        csv << meeting.attributes.values_at(*column_names) + [meeting.time_slots.collect(&:to_csv).join('|')]
      end
    end
  end

  def finalize
    update_attribute(:status, 'closed')
    mark_topics_closed
    give_points
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

  def mark_topics_selected
    topics.each do |topic|
      topic.update_attributes(meeting_id: id, status: 'selected')
    end
  end

  private

  def self.by_date
    self.closed.sort_by { |t| t.date }.reverse
  end

  def give_points
    time_slots.map do |time_slot|
      time_slot.give_points
    end
  end

  def mark_topics_closed
    topics.each { |topic| topic.update_attribute(:status, 'closed') }
  end

  def update_topics
    topics.each { |topic| topic.update_attribute(:meeting_id, _id) }
  end


end
