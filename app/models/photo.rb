class Photo < ActiveRecord::Base
	mount_uploaders :photos, PhotoUploader
	serialize :photos, JSON
end
