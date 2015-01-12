require 'pp'
require 'open-uri'

namespace :marvel do

  class BioParser
    def parse_bio(url)
      doc = Nokogiri::HTML(open(url))
      # Search for nodes by css
      bio_info = {}
      doc.css('div#powerbox-holder p').each do |paragraph|
        title_element = paragraph.css("b").first
        title_element.remove
        value = paragraph.text.strip
        attribute = title_element.text.strip.downcase.gsub(/\s+/, "_")

        if attribute == 'aliases'
          value = value.split(/,|;/).map{|name| name.gsub(/\"/, "").strip }
        end
        bio_info[attribute] = value
      end
      bio_info
    end

    def parse_

  end

  task :scrape => :environment do
    url = 'http://marvel.com/universe/Spider-Man_(Peter_Parker)?utm_campaign=apiRef&utm_source=abcc6ad392ed7a134017a13e3e2d37c9'
    bio = BioParser.new
    bio_info = bio.parse_bio(url)
    pp bio_info
  end

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
    # while count <= total
    puts "in here... #{count} / #{total}"
    status = Timeout::timeout(5) {
      # characters = marvel_api.client.characters(:limit => limit, :offset => count)
      character = marvel_api.client.character(1009610)
      p character['data']['results'][0]['urls'][1]['url']
      doc = Nokogiri::HTML(open("#{character['data']['results'][0]['urls'][1]['url']}"))
      # Search for nodes by css
      doc.css('div#powerbox-holder p').each do |p|
        puts p.content
      end
      doc.css('div#powerbox-holder p').each do |p|
        puts p.content
      end
      # make nokogiri call to characters wiki page
      # characters["data"]["results"].each do |character|
      #       hero = Hero.create!(
      #       :marvel_id => character["id"],
      #       :name => character["name"],
      # :details => character,
      # :wiki_data => nokogiri web scrape
      #       )
      #       hero.save
      #     end
    }

    # count += limit
    # sleep 1
    # end

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
