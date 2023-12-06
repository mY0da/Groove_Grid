class TagsController < ApplicationController
  def index
    # @tags = Tag.joins(:songs).where(songs: { user: current_user })
    @tags = Tag.joins(:profiles).where(profiles: { user: current_user })
  end

  def show
    @tag = Tag.find(params[:id])
  end
end
