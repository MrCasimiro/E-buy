# frozen_string_literal: true

# One image belongs to only a specific product and
# every image has a photo.
class Image < ApplicationRecord
  belongs_to :product
  mount_uploader :photo, PhotoUploader

  validates :photo, presence: true
end
