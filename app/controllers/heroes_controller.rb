class HeroesController < ApplicationController

  def create
  end

  def show
    @hero = Hero.find(params[:id])
    marvel_api = MarvelApi.new
    @character = marvel_api.client.character(@hero.name)
  end



end
