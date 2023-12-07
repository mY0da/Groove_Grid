class TagsController < ApplicationController
  def index
    # @tags = Tag.joins(:songs).where(songs: { user: current_user })
    @tags = Tag.joins(:profiles).where(profiles: { user: current_user })

    @tags.each do |tag|
      session["playlist_image_#{tag.id}"] ||= generate_unique_random_image(tag.id)
      tag.save
    end
  end

  def show
    @tag = Tag.find(params[:id])
    @image_number = session["tag_image_#{params[:id]}"]
    render :show
  end

  private

  def generate_unique_random_image(tag_id)
    random_image = rand(1..8)
    while session.values.include?(random_image)
      random_image = rand(1..8)
    end

    session["tag_image_#{tag_id}"] = random_image
  end
end
