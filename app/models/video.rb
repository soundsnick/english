class Video < ApplicationRecord
  mount_uploader :file, VideoUploader
  mount_uploader :thumb, ThumbUploader
  
  belongs_to :course
end
