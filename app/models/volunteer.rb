class Volunteer
  include Mongoid::Document

  belongs_to :user

  validates :user_id, uniqueness: true

  def name
    user.name
  end

  def self.column_names
    self.fields.collect { |field| field[0] }
  end

  def to_csv(options = {})
    user.name
  end

  
end
