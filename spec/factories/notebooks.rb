FactoryBot.define do
  factory :notebook do
    brand { Faker::Device.manufacturer }
    model { Faker::Device.model_name }
    asset_number { Faker::Alphanumeric.unique.alphanumeric(number: 8).upcase }
    serial_number { Faker::Alphanumeric.unique.alphanumeric(number: 10).upcase }
    equipment_id { Faker::Alphanumeric.unique.alphanumeric(number: 8).upcase }
    purchase_date { Faker::Date.backward(days: 365) }
    manufacture_date { Faker::Date.backward(days: 730) }
    description { Faker::Lorem.sentence(word_count: 10) }
    state { :disponível }
  end
end
