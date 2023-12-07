class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:destroy, :show, :download]

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

  def download
    zip_filename = "playlist_#{@playlist.id}_audio_files.zip"

    temp_file = Tempfile.new(zip_filename)
    Zip::File.open(temp_file.path, Zip::File::CREATE) do |zipfile|
      @playlist.songs.each do |song|
        next unless song.audio_file.attached?

        audio_file = song.audio_file
        file_data = Net::HTTP.get_response(URI.parse(audio_file.url)).body
        zipfile.get_output_stream(song.audio_file.filename.to_s) { |f| f.write file_data }
      end
    end

    send_file temp_file.path, filename: zip_filename, type: 'application/zip', disposition: 'attachment'
    temp_file.close
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




  def download_mp3
    respond_to do |format|
      format.html { render }
      format.zip { send_zip @playlist.songs... }
    end
  end
end
