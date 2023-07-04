class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items, dependent: :destroy

  validates_format_of :phone_number, uniqueness: true, :allow_blank => true, :minimum => 10, :maximum => 10,:multiline => true,
                      :with => /^[0-9]{3}-[0-9]{3}-[0-9]{4}\z$/, :message => "- Phone numbers must be in xxx-xxx-xxxx format."
  validates_format_of :credit_card_number, :allow_blank => true, :minimum => 15, :maximum => 16, :multiline => true, :with => /^\d{15,16}\z$/,  :message => " Enter valid credit card number with either 15/16 digits"
end
