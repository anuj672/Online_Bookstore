class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :transaction_number, null: false
      t.references :book, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :credit_card_number
      t.string :address
      t.string :phone_number
      t.integer :quantity
      t.float :total_price

      t.timestamps
    end
  end
end
