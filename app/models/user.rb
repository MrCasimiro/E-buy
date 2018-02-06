# frozen_string_literal: true

# User has a lot of products, if a user cancel your account,
# all the products also has to be destroyed.
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable
  validates :name, :phone, presence: true
  has_many :products, dependent: :destroy
end
