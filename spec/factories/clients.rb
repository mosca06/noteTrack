FactoryBot.define do
  factory :client do
    name { Faker::Name.name }
    sector { Faker::Company.industry }
  end
end
