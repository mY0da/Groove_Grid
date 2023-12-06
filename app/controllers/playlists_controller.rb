class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:destroy, :show]

  def index
    @playlists = current_user.playlists
  end

  def show
    @playlist_song = PlaylistSong.new
    render :show
  end

  def new
    @playlist = Playlist.new

  end

  def create
    @playlist = Playlist.new(playlist_params)
    @playlist.user = current_user
    if @playlist.save
      redirect_to playlists_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @playlist.destroy
    redirect_to playlists_path, status: :see_other
  end

  def search
    # ADDED
    if params[:query].present?
      @playlists = Playlist.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @playlists = Playlist.all
    end
  end

  private

  def set_playlist
    @playlist = Playlist.find(params[:id])
  end

  def playlist_params
    params.require(:playlist).permit(:name)
  end
end
