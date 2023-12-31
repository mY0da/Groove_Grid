rspotify = RSpotify.authenticate(ENV["CLIENT_ID"], ENV["CLIENT_SECRET"])
playlist = RSpotify::Playlist.find('hujfjm5lg1g6pdm9py6zcosyk', '4VqaukGDVsQaUm4A2L7c7j')

puts 'Destroying old'

Playlist.destroy_all
PlaylistSong.destroy_all
Song.destroy_all
TagSong.destroy_all
Label.destroy_all
Artist.destroy_all
Tag.destroy_all
Profile.destroy_all
User.destroy_all

puts 'Creating users'

first_user = User.create!(email: 'tony@merguez.com', password: 'test123')

profile = Profile.create!(user: first_user, first_name: 'Martim', last_name: 'Costa', avatar: "2")

puts 'Creating label'

unknown_label = Label.create(name: "Unknown Label")

puts 'Create unknown artist'
unknown_artist = Artist.create(name: "Unknown Artist")

puts 'Creating scales'
music_scales = ['1A', '1B', '2A', '2B', '3A', '3B', '4A', '4B', '5A', '5B', '6A', '6B', '7A', '7B', '8A', '8B', '9A', '9B', '10A', '10B', '11A', '11B', '12A', '12B']

puts 'Creating genres'
music_genres = ['House', 'Techno', 'Minimal', 'Deep House', 'Disco', 'Deep Tech', 'Breakbeat', 'Drum n Bass']

puts 'Creating tracks'

playlist.tracks.each do |track|
  artist = Artist.create(name: track.artists.first.name)
  Song.create(name: track.name, artist: artist, bpm: rand(120..130), scale: music_scales.sample, genre: music_genres.sample, label: unknown_label, seconds: track.duration_ms / 1000, user: first_user)
end

puts 'Ready to go'
