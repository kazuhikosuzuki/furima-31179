class Good < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :scheduled_delivery
  belongs_to_active_hash :shipping_expense
  belongs_to_active_hash :prefecture

  belongs_to :user

  has_one_attached :image

  with_options presence: true do
    hankaku_num = /\A[0-9]+\z/
    validates :price, format: { with: hankaku_num }
    validates :price, numericality: { greater_than: 299 }
    validates :price, numericality: { less_than: 9_999_999 }
    validates :category, :condition, :scheduled_delivery, :shipping_expense, :prefecture
    # 空の投稿を保存できないようにする
    validates :shop_name, :description, :price
    # ジャンルの選択が「--」の時は保存できないようにする
  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :condition_id
    validates :scheduled_delivery_id
    validates :shipping_expense_id
    validates :prefecture_id
    end
    validates :image, unless: :was_attached?
  
  end
  def was_attached?
    image.attached?
  end
end
