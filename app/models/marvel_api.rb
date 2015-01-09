class MarvelApi

  def client
    public_key = ENV['marvel_public_key']
    private_key = ENV['marvel_private_key']
    client = Marvelite::API::Client.new( :public_key => public_key, :private_key => private_key)
  end
end
