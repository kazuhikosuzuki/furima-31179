class Good < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :scheduled_delivery
  belongs_to_active_hash :shipping_expense
  belongs_to_active_hash :prefecture

  belongs_to :user

  has_one_attached :image

  
    
    validates :image, presence: true
    validates :category, :condition,:scheduled_delivery,:shipping_expense,:prefecture , presence: true
    #空の投稿を保存できないようにする
    validates :shop_name, :description, :price, presence: true

    #ジャンルの選択が「--」の時は保存できないようにする
    validates :category_id, numericality: { other_than: 1 } 
    validates :condition_id, numericality: { other_than: 1 } 
    validates :scheduled_delivery_id, numericality: { other_than: 1 }
    validates :shipping_expense_id, numericality: { other_than: 1 } 
    validates :content, presence: true, unless: :was_attached?

  def was_attached?
    self.image.attached?
  end
     
end
