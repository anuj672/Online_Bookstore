class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :book

  validates :quantity, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :total_price, :presence => false, :numericality => { :greater_than_or_equal_to => 0 }
end
