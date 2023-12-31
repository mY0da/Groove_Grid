class SongsController < ApplicationController
  before_action :set_song, only: %i[show edit add_tag remove_tag destroy]

  def index
    if params[:query].present?
      sql_query = "name ILIKE :query"
      @songs = Song.where(sql_query, query: "%#{params[:query]}%")
    else
      @songs = current_user.songs
    end
    render :index
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)
    @song.label = Label.find_or_create_by(name: "Unknown Label")
    @song.artist = Artist.find_or_create_by(name: "Unknown Artist")
    @song.user = current_user
    @song.name = params[:song][:audio_file].original_filename

    if @song.save
      redirect_to songs_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    render :show
  end

  def edit
  end

  def destroy
    @song.destroy
    redirect_to songs_path, status: :see_other
  end

  def add_tag
    @tag = Tag.joins(:profiles).where(profiles: { user: current_user }).find_or_create_by(name: params[:tag_name])
    @song.tags << @tag
    @tag.profiles << current_user.profile
    redirect_to @song
  end

  def remove_tag
    tag_name = params[:tag_name]
    tag = Tag.find_by(name: tag_name)

    if tag
      @song.tags.delete(tag)
      redirect_to @song, notice: "Tag '#{tag_name}' removed from the song."
    else
      redirect_to @song, alert: "Tag '#{tag_name}' not found."
    end
  end

  private

  def set_song
    @song = Song.find_by_id(params[:id])
  end

  def song_params
    params.require(:song).permit(:audio_file, :name, :tag_list, :genre)
  end
end
