class Post < ApplicationRecord
	mount_uploader :Avatar, AvatarUploader
	belongs_to :user
end
