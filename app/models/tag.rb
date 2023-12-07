class Tag < ApplicationRecord
  has_many :tag_songs, dependent: :destroy
  has_many :songs, through: :tag_songs, dependent: :destroy
  has_many :tags_profiles, dependent: :destroy
  has_many :profiles, through: :tags_profiles, dependent: :destroy

  has_one_attached :image
end
