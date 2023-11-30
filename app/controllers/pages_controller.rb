class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def welcome_page
  end

  def welcome_video
  end
end
