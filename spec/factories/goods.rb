FactoryBot.define do
  factory :good do
    shop_name { 'test' }
    description              { Faker::Lorem.sentence }
    price                    { 300 }
    category_id              { 2 }
    scheduled_delivery_id    { 2 }
    shipping_expense_id      { 2 }
    prefecture_id            { 2 }
    condition_id             { 2 }
    image                    { Faker::Lorem.sentence }

    association :user


    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
