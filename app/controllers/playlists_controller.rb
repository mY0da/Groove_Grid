class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:destroy, :show]

  def index
    @playlists = current_user.playlists

    @playlists.each do |playlist|
      session["playlist_image_#{playlist.id}"] ||= generate_unique_random_image(playlist.id)
      playlist.save
    end
  end

  def show
    @playlist_song = PlaylistSong.new
    @image_number = session["playlist_image_#{params[:id]}"]
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
    params.require(:playlist).permit(:name, :photo)
  end

  def generate_unique_random_image(playlist_id)
    random_image = rand(1..7)
    while session.values.include?(random_image)
      random_image = rand(1..7)
    end

    session["playlist_image_#{playlist_id}"] = random_image
  end
end
