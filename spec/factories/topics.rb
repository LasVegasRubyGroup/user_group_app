# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :topic do
    sequence(:title) { |n| "Topic #{n}" }
    description 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi id hendrerit orci. Fusce quis lacus purus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.'
  end
end
