class PagesController < ApplicationController

  def index
    @heroes = Hero.order("name").page(params[:page])
  end

  private


end
