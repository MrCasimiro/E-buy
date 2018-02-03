class Product < ApplicationRecord
	belongs_to :user
	validates :name, :description, :price, presence: true

	mount_uploaders :photos, PhotoUploader
	serialize :photos, JSON
end
