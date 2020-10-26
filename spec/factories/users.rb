FactoryBot.define do
  factory :user do
    nick_name             { 'taro' }
    email                 { 'kkk@gmail.com' }
    password              { '123abc' }
    password_confirmation { '123abc' }
    first_name            { 'かずひこ' }
    last_name             { 'すずき' }
    first_name_kana       { 'カズヒコ' }
    last_name_kana        { 'スズキ' }
    birth_day             { 19_811_210 }
  end
end
