class PagesController < ApplicationController

  def index
    marvel_api = MarvelApi.new
    @characters = marvel_api.client.characters(:limit => 100, :offset => 400)
  end

end
