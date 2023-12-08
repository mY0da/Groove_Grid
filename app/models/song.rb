class Song < ApplicationRecord
  belongs_to :user
  belongs_to :artist
  belongs_to :label
  has_many :playlist_songs, dependent: :destroy
  has_many :playlists, through: :playlist_songs, dependent: :destroy
  has_many :tag_songs, dependent: :destroy
  has_many :tags, through: :tag_songs, dependent: :destroy
  has_one_attached :audio_file, dependent: :destroy
end
