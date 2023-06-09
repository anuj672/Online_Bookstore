class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.references :book, null: false, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :rating
      t.text :review

      t.timestamps
    end
  end
end
