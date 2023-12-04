class Song < ApplicationRecord
  belongs_to :user
  belongs_to :artist
  belongs_to :label
  has_many :playlist_songs
  has_many :playlists, through: :playlist_songs
  has_many :tag_songs
  has_many :tags, through: :tag_songs
  has_one_attached :audio_file

  def tag_list
    self.tags.collect do |tag|
      tag.name
    end.join(', ')
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(",").collect{ |s| s.strip.downcase }.uniq
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tags
  end
end
