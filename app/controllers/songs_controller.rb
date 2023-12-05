class SongsController < ApplicationController
  before_action :set_song, only: %i[show edit add_tag]

  def index
    @songs = Song.all
    render :index
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)
    @song.label = Label.find_by(name: "Unknown Label")
    @song.artist = Artist.find_by(name: "Unknown Artist")
    @song.user = current_user
    @song.name = params[:song][:audio_file].original_filename

    if @song.save
      redirect_to song_path(@song)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    render :show
  end

  def edit
  end

  def add_tag
    tag = Tag.find_or_create_by(name: params[:tag_name])
    @song.tags << tag
    redirect_to @song
  end

  private

  def set_song
    @song = Song.find(params[:id])
  end

  def song_params
    params.require(:song).permit(:audio_file, :name, :tag_list)
  end
end
