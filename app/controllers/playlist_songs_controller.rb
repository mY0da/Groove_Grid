class PlaylistSongsController < ApplicationController
  before_action :set_playlist_song, only: :destroy
  before_action :set_playlist, only: [:new, :create]

  def create
    @playlist_song = PlaylistSong.new(playlist_song_params)
    @playlist_song.playlist = @playlist
      if @playlist_song.save!
        redirect_to playlist_path(@playlist)
      else
        render 'new'
      end
  end

  def destroy
    @playlist_song.destroy
    redirect_to playlist_path(@playlist_song.playlist), status: :see_other
  end

    private

    def playlist_song_params
        params.require(:playlist_song).permit(:song_id, :playlist_id)
    end

    def set_playlist_song
      @playlist_song = PlaylistSong.find(params[:id])
    end

    def set_playlist
      @playlist = Playlist.find(params[:playlist_id])
      @playlist.user = current_user
    end
end
