rspotify = RSpotify.authenticate(ENV["CLIENT_ID"], ENV["CLIENT_SECRET"])
playlist = RSpotify::Playlist.find('hujfjm5lg1g6pdm9py6zcosyk', '4VqaukGDVsQaUm4A2L7c7j')

puts 'Destroying old'

Tag.destroy_all
TagSong.destroy_all
Playlist.destroy_all
PlaylistSong.destroy_all
Song.destroy_all
Label.destroy_all
Artist.destroy_all
User.destroy_all

puts 'Creating users'

first_user = User.create!(username: 'martimtonic', first_name: 'Martim', last_name: 'Costa', email: 'mrtmtonic@gmail.com', password: 'Concha!95')

puts 'Creating label'
unknown_label = Label.create(name: "Unkown Label")

puts 'Creating tracks'

playlist.tracks.each do |track|
  artist = Artist.create(name: track.artists.first.name)
  Song.create(name: track.name, artist: artist, label: unknown_label, seconds: track.duration_ms / 1000, user: first_user)
end

puts 'Ta feito'
