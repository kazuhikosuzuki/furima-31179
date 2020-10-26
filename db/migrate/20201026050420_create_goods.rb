class CreateGoods < ActiveRecord::Migration[6.0]
  def change
    create_table :goods do |t|
      t.reference :user, null: false, foreign_key: true
      t.string :shop_name, null: false
      t.text :description, null: false
      t.integer :price, null: false
      t.category_id :intger, null: false
      t.condition_id :intger, null: false
      t.shipping_expense_id :intger, null: false
      t.prefecture_id :intger, null: false
      t.scheduled_delivery_id :intger, null: false
      t.timestamps
    end
  end
end
