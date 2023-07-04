class Transaction < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :transaction_number, :presence => true
  validates :book_id, :presence => true
  validates :user_id, :presence => true
  validates :credit_card_number, :presence => true
  validates :address, :presence => true
  validates :phone_number, :presence => true
  validates :quantity, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :total_price, :presence => false, :numericality => { :greater_than_or_equal_to => 0 }
  validates_format_of :phone_number,uniqueness: true,:minimum => 10, :maximum => 10,:multiline => true,
                      :with => /^[0-9]{3}-[0-9]{3}-[0-9]{4}\z$/, :message => "- Phone numbers must be in xxx-xxx-xxxx format."
  validates_format_of :credit_card_number, :minimum => 15, :maximum => 16, :multiline => true, :with => /^\d{15,16}\z$/,  :message => " Enter valid credit card number with either 15/16 digits"
end
