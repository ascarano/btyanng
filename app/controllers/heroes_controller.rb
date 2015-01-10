class HeroesController < ApplicationController

  def create
  end

  def show
    @hero = Hero.find(params[:id])
    marvel_api = MarvelApi.new
    @character = marvel_api.client.character(@hero.marvel_id.to_i)
    @comics = marvel_api.client.comic(43495)
  end



end
