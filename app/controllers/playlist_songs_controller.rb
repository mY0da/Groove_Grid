class PlaylistSongsController < ApplicationController
  before_action :set_playlist_song, only: :destroy
  before_action :set_playlist, only: [:new, :create]

  def create
    params[:playlist_song][:song_id].each do |song|
      next if song == ""
      @song = Song.find(song.to_i)
      @playlist_song = PlaylistSong.new
      @playlist_song.song = @song
      @playlist_song.playlist = @playlist
      render 'new' unless @playlist_song.save!
    end
    redirect_to playlist_path(@playlist)
  end

  def destroy
    @playlist_song.destroy
    redirect_to playlist_path(@playlist_song.playlist), status: :see_other
  end

    private


    def set_playlist_song
      @playlist_song = PlaylistSong.find(params[:id])
    end

    def set_playlist
      @playlist = Playlist.find(params[:playlist_id])
      @playlist.user = current_user
    end
end
