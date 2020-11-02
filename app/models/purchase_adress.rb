class PurchaseAdress
  include ActiveModel::Model
  attr_accessor :token,:postal_code,:prefecture_id,:city,:house_number,:building_name,:phone_number,:good_id,:user_id

with_options presence: true do
  validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  validates :prefecture_id,numericality: { other_than: 1 }
  validates :city
  validates :house_number
  validates :phone_number, format: {with: /\A[0-9]{11}+\z/ ,message:""},
end

  def save  
    purchase = Purchase.create(good_id: good_id, user_id: user_id)
    PurchasesInfo.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name,phone_number: phone_number,purchase_id:purchase.id)
  end
end