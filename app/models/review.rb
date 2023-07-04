class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user, optional: true
  belongs_to :admin, optional: true

  validates :book_id, :presence => true
  validates :user_id, :presence => true, unless: :admin_id
  validates :rating, :presence => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 5 }
  validates :review, :presence => true
end
