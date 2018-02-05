class Image < ApplicationRecord
	belongs_to :product
	mount_uploader :photo, PhotoUploader

	validates :photo, presence: true
end
