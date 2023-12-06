class TagSongsController < ApplicationController
  before_action :set_tag_song, only: :destroy

  def destroy
    @tag_song.destroy
    redirect_to song_path(@tag_song.song), status: :see_other
  end

  private

  def set_tag_song
    @tag_song = TagSong.find(params[:id])
  end
end
