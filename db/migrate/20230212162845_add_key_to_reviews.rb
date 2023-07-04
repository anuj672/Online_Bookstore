class AddKeyToReviews < ActiveRecord::Migration[7.0]
  def change
    add_reference :reviews, :admin, foreign_key: true
  end
end
