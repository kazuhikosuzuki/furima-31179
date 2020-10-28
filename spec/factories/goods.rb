FactoryBot.define do
  factory :good do
    shop_name { 'test' }
    description              { Faker::Lorem.sentence }
    price                    { 300 }
    category_id              { 1 }
    scheduled_delivery_id    { 1 }
    shipping_expense_id      { 1 }
    prefecture_id            { 1 }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
