class CreateRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants do |t|
      t.references :user, null: false, foreign_key: true
      t.references :address, null: false, unique: true, foreign_key: true
      t.string :phone, null: false
      t.string :email
      t.string :name, null: false
      t.integer :price_range, default:1
      t.boolean :active, default:true

      # t.check_constraint "price_min_chk", "price_range > 0"
      # t.check_constraint "price_max_chk", "price_range < 4"

      t.timestamps
    end
  end
end
