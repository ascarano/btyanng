require 'pp'
require 'open-uri'

namespace :marvel do

  class BioParser

    def parse_bio(url)
      doc = Nokogiri::HTML(open(url))
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

    def parse_body(url)
      doc = Nokogiri::HTML(open(url))
      bio_info = []
      doc = doc.css('div#biobody')
      # doc.css('h3').remove
      doc.css('table').remove
      doc.css('script').remove
      doc.css('.thumbcaption').remove
      new_info = []
      info = doc.text.split(/\n/)
      info.each do |i|
        i = i.strip
        if i == ""
          i.delete
        else
          new_info << i
        end
      end
      new_info
    end

  end

  task :scrape => :environment do
    url = 'http://marvel.com/universe/Spider-Man_(Peter_Parker)?utm_campaign=apiRef&utm_source=abcc6ad392ed7a134017a13e3e2d37c9'
    bio = BioParser.new
    bio_info = bio.parse_bio(url)
    pp bio_info
  end

  task :scrape_body => :environment do
    url = 'http://marvel.com/universe/Spider-Man_(Peter_Parker)'
    bio = BioParser.new
    bio_info = bio.parse_body(url)
    bio_info.each do |paragraph|
      if paragraph.length < 50
        puts paragraph.upcase
        puts "*" * 60
      else paragraph.length > 50
        puts paragraph
        puts "*" * 60
      end
    end
  end

  task :heroes => :environment do
    marvel_api = MarvelApi.new
    heroes = Hero.all
    heroes.each do |hero|
      if hero.marvel_data == nil
        require 'timeout'
        puts "starting..."
        status = Timeout::timeout(20) {
          data = marvel_api.client.character(hero.name)
          hero.update(
          :marvel_data => data
          )
          puts hero.name
        }
      end
    end
  end

  task :comics => :environment do
    marvel_api = MarvelApi.new
    require 'timeout'
    puts "starting..."
    status = Timeout::timeout(20) {
      total = Comics.count
      data = marvel_api.client.comics(:limit => 100, :offset => total)
      data['data']['results'].each do |result|
        puts "Next Comic"
        pp result
      end
    }
  end

end
