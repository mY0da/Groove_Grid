class SongsController < ApplicationController
  def index
    @songs = Song.all
    render :index
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)
    @label = Label.find_by(name: "Unknown Label")
    @artist = Artist.find_by(name: "Unknown Artist")
    @song.artist = @artist
    @song.label = @label
    @song.user = current_user
    if @song.save
      redirect_to songs_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @song = Song.find(params[:id])
    render :show
  end

  private

  def song_params
    params.require(:song).permit(:audio_file)
  end
end
