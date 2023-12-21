class TagsController < ApplicationController
  before_action :set_tag, only: %i[show destroy]

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
