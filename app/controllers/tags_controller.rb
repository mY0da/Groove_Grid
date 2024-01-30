class TagsController < ApplicationController
  before_action :set_tag, only: %i[show destroy download]

  def index
    # @tags = Tag.joins(:songs).where(songs: { user: current_user })
    @tags = Tag.joins(:profiles).where(profiles: { user: current_user })

    @tags.each do |tag|
      session["playlist_image_#{tag.id}"] ||= generate_unique_random_image(tag.id)
      tag.save
    end
  end

  def show
    @image_number = session["tag_image_#{params[:id]}"]
    render :show
  end

  def destroy
    @tag.destroy
    redirect_to tags_path, status: :see_other
  end

  def download
    zip_filename = "tag_#{@tag.id}_audio_files.zip"

    temp_file = Tempfile.new(zip_filename)
    Zip::File.open(temp_file.path, Zip::File::CREATE) do |zipfile|
      @tag.songs.each do |song|
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

  def set_tag
    @tag = Tag.find_by_id(params[:id])
  end

  def generate_unique_random_image(tag_id)
    random_image = rand(1..8)
    while session.values.include?(random_image)
      random_image = rand(1..8)
    end

    session["tag_image_#{tag_id}"] = random_image
  end
end
