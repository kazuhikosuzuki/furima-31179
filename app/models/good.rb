class Good < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :scheduled_delivery
  belongs_to_active_hash :shipping_expense

    #空の投稿を保存できないようにする
    validates :shop_name, :description, :price, :category_id, :condition_id, :shipping_expense_id, :prefecture_id, :scheduled_delivery_id, presence: true

    #ジャンルの選択が「--」の時は保存できないようにする
    validates :category_id, numericality: { other_than: 1 } 
    validates :condition_id, numericality: { other_than: 1 } 
    validates :scheduled_delivery_id, numericality: { other_than: 1 }
    validates :shipping_expense_id, numericality: { other_than: 1 } 
     
end
