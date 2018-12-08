class Course < ApplicationRecord
  has_many :videos
  belongs_to :category
end
