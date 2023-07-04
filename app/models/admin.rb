class Admin < ApplicationRecord

  has_secure_password
  has_many :reviews, dependent: :destroy

  validates :username, :presence => true
  validates :name, :presence => true
  validates :email,:presence => true, email:true
end
