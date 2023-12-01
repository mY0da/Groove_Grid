class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if current_user
      redirect_to songs_path
    end
  end

  def welcome_page
  end

  def welcome_video
  end
end
