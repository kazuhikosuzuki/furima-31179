class CreateGoods < ActiveRecord::Migration[6.0]
  def change
    create_table :goods do |t|
      t.references :user, null: false, foreign_key: true
      t.string :shop_name, null: false
      t.text :description, null: false
      t.integer :price, null: false
      t.integer :category_id, null: false
      t.integer :condition_id, null: false
      t.integer :shipping_expense_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :scheduled_delivery_id, null: false
      t.timestamps
    end
  end
end
