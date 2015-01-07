class MarvelApi
  #   def initialize
  #     @conn = Faraday.new(:url => 'http://gateway.marvel.com')
  #   end
  #   #behavior
  #   def characters
  #     public_key = ENV['marvel_public_key']
  #     private_key = ENV['marvel_private_key']
  #     ts = Time.now.to_i.to_s
  #     hash = Digest::MD5.hexdigest("#{ts}#{private_key}#{public_key}")
  #     url = "/?ts=#{ts}&apikey=#{public_key}&hash=#{hash}"
  #     response = @conn.get do |req|
  #       req.url "#{url}"
  #       req.headers['Content-Type'] = 'application/json'
  #     end
  #     JSON.parse(response.body, symbolize_names: true)
  #   end
  def client
    public_key = ENV['marvel_public_key']
    private_key = ENV['marvel_private_key']
    client = Marvelite::API::Client.new( :public_key => public_key, :private_key => private_key)
  end
end
