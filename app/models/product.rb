class Product < ApplicationRecord
	belongs_to :user
	has_many :images, :dependent => :destroy
	accepts_nested_attributes_for :images, :allow_destroy => true

	validates :name, :description, :price, presence: true

	self.per_page = 5

	private

	def self.search(term, client)
		if term
			if client 
				where('name LIKE ?', "%#{term}%")
			else 
				where('name LIKE ? AND user_id != ?', "%#{term}%", 
				client.id).order('id DESC')
			end
		else
			client == nil ? order('id DESC') : where.not(user_id: client.id) 
		end
	end
end
