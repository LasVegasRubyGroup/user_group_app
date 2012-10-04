class TimeSlotDecorator < Draper::Base
  decorates :time_slot

  def time
    time_slot.starts_at.to_s(:short)
  end
end
