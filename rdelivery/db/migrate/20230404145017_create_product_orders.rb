class CreateProductOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :product_orders do |t|
      t.references :product, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.integer :product_quantity, null: false
      t.integer :product_unit_cost, null: false
      
      # t.check_constraint "quantity_chk", "product_quantity > 0"
      # t.check_constraint "unit_cost_chk", "product_unit_cost >= 0"

      t.timestamps
    end

  end
end

# EXAMPLE
# class CreatePayments < ActiveRecord::Migration[6.0]
#   def change
#     create_table :payments do |t|
#       t.integer :amount
#       t.datetime :transaction_time
#       t.references :payer_id, null: false #remove foreign
#       t.references :payee_id, null: false #remove foreign
#       t.timestamps
#     end
#     add_foreign_key :payments, :users, column: :payer_id
#     add_foreign_key :payments, :users, column: :payee_id
#   end
# end
