class Product < ApplicationRecord
	has_many :photos

	validates :name, :description, :price, presence: true
end
