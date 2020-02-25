class Course < ApplicationRecord
  mount_uploader :cover, CoverUploader
  has_many :videos
  belongs_to :category
end
