class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  validates :name, :presence => true
  validates :author, :presence => true
  validates :publisher, :presence => true
  validates :price, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :stock, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
end
