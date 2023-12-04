class PlaylistsController < ApplicationController
  def index
    @playlists = Playlist.all
    render :index
  end

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.new(playlist_params)
    if @playlist.save
      redirect_to playlists_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @playlist = Playlist.find(params[:id])
    @playlist_songs = Playlist.songs
    render :show
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name)
  end
end
