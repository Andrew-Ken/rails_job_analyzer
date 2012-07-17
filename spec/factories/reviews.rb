# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do
    job nil
    memo "MyText"
    rank 1
    applied false
  end
end
