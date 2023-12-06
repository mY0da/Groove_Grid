class TagsController < ApplicationController

  def index
    @tags = Tag.joins(:profiles).where(profiles: { user: current_user })
  end

  def show
    @tag = Tag.find(params[:id])
  end
end
