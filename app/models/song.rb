class Song < ApplicationRecord
  belongs_to :user
  belongs_to :artist
  belongs_to :label
  has_many :playlist_songs
  has_many :playlists, through: :playlist_songs
  has_many :tag_songs
  has_many :tags, through: :tag_songs
  has_one_attached :audio_file
end
