class Tag < ApplicationRecord
  has_many :tag_songs, dependent: :destroy
  has_many :songs, through: :tag_songs
  has_many :tags_profiles
  has_many :profiles, through: :tags_profiles
end
