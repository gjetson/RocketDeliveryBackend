class CreateCouriers < ActiveRecord::Migration[7.0]
  def change
    create_table :couriers do |t|
      t.references :user, null: false, unique: true, foreign_key: true
      t.references :address, null: false, foreign_key: true
      t.references :courier_status, default: 1, null: false, foreign_key: true
      t.string :phone, null: false
      t.string :email
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
