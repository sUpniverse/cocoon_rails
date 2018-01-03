class Post < ApplicationRecord
	mount_uploader :Avatar, AvatarUploader
end
