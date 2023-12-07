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







  # def download_mp3s_and_create_zip(public_ids)
  #   mp3_urls = []

  #   # Generate URLs for each MP3 file
  #   public_ids.each do |public_id|
  #     mp3_urls << Cloudinary::Utils.cloudinary_url(public_id, resource_type: :audio, format: 'mp3')
  #   end

  #   zipfile_name = "/Users/me/Desktop/archive.zip"

  #   # Create a ZIP file
  #   Zip::File.open(zipfile_name, create: true) do |zipfile|
  #     @playlist.songs.each do |song|

  #       mp3_urls.each_with_index do |url, index|

  #         mp3_file = Cloudinary::Downloader.download(song.audio_file)
  #         zipfile.add(song, File.join(folder, mp3_file))

  #       end
  #     end
  #     zipfile.get_output_stream("myFile") { |f| f.write "myFile contains just this" }
  #   end


  #   public_ids = ['your_mp3_public_id_1', 'your_mp3_public_id_2'] # Replace these with your actual public IDs
  #   download_mp3s_and_create_zip(public_ids)
  # end

  # def download
  #   folder = "Users/me/Desktop/songs"
  #   input_filenames = ['image.jpg', 'description.txt', 'stats.csv']

  #   zipfile_name = "/Users/me/Desktop/archive.zip"

  #   Zip::File.open(zipfile_name, create: true) do |zipfile|
  #     @playlist.songs.each do |song|

  #       Cloudinary::Utils.private_download(public_id, resource_type: :audio, format: 'mp3')

  #       zipfile.add(song, File.join(folder, song))
  #     end
  #     zipfile.get_output_stream("myFile") { |f| f.write "myFile contains just this" }
  #   end
  # end
end
