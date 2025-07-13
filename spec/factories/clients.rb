FactoryBot.define do
  factory :client do
    name { Faker::Name.name }
    sector { Faker::Company.industry }
    status { [0, 1].sample }
  end
end
