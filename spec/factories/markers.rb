FactoryBot.define do
  factory :marker do
    lat { Faker::Address.latitude }
    long { Faker::Address.longitude }
  end
end
