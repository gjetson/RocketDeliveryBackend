class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.references :order_status, null: false, foreign_key: true
      t.integer :restaurant_rating

      # t.check_constraint "rating_min_chk", "restaurant_rating > 0"
      # t.check_constraint "rating_max_chk", "restaurant_rating < 6"

      t.timestamps
    end

  end
end
