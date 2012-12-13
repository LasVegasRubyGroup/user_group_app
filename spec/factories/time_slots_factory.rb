FactoryGirl.define do
  factory :time_slot do
    starts_at { "#{%w(6:20 6:50 7:20).sample} PM" }
    ends_at { "#{%w(6:20 6:50 7:20).sample} PM" }
    topic_id { FactoryGirl.create(:topic)._id }
    presenter_id { FactoryGirl.create(:user)._id }
  end
end