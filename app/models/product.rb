class Product < ApplicationRecord
	belongs_to :user
	has_many :images, :dependent => :destroy
	accepts_nested_attributes_for :images, :allow_destroy => true

	validates :name, :description, :price, presence: true

	self.per_page = 5

	private

	def self.search(term, client_id)
		if term
			where('name LIKE ? AND user_id != ?', "%#{term}%", 
				client_id).order('id DESC')
		else
			where.not(user_id: client_id).order('id DESC')
		end
	end
end
