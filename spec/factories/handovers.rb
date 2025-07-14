FactoryBot.define do
  factory :handover do
    association :client
    association :notebook
  end
end
