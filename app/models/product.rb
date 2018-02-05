class Product < ApplicationRecord
	belongs_to :user
	validates :name, :description, :price, presence: true

	mount_uploaders :photos, PhotoUploader
	serialize :photos, JSON

	self.per_page = 5

	def self.search(term)
		if term
			where('name LIKE ?', "%#{term}%").order('id DESC')
		else
			order('id DESC')
		end
	end
end
