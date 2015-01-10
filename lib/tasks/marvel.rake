namespace :marvel do

  task :heroes => :environment do
    marvel_api = MarvelApi.new
    total = nil
    limit = 100
    count = 0
    require 'timeout'
    status = Timeout::timeout(5) {
      characters = marvel_api.client.characters(:limit => 1, :offset => 1)
      total = characters["data"]["total"]
    }

    all = []
    while count <= total
      puts "in here... #{count} / #{total}"
      status = Timeout::timeout(5) {
        characters = marvel_api.client.characters(:limit => limit, :offset => count)
        # characters["data"]["results"].each do |character|
        #       hero = Hero.create!(
        #       :marvel_id => character["id"],
        #       :name => character["name"],
        #       )
        #       hero.save
        #     end
      }
      count += limit
      sleep 1
    end

    p all
    # if characters != nil
    #   characters["data"]["results"].each do |character|
    #     hero = Hero.create!(
    #     :marvel_id => character["id"],
    #     :name => character["name"],
    #     )
    #   end
    # end

  end

end
