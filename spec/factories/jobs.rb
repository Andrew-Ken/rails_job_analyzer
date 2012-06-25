# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :job do
    name "MyString"
    company "MyString"
    location "MyString"
    content "MyText"
    web_source "MyString"
  end
end
