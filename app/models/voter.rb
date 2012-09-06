class Voter
  include Mongoid::Document

  belongs_to :user
  embedded_in :topic

  validates :user_id, uniqueness: true


  def name
    user.name
  end
  
end
