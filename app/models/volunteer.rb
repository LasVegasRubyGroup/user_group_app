class Volunteer
  include Mongoid::Document

  belongs_to :user

  validates :user_id, uniqueness: true

  def name
    user.name
  end
end