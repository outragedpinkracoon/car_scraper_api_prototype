require 'net/http'
require 'open-uri'

module Scraping
  class ArnoldClark
    def self.call
      page = Nokogiri::HTML(open(url))
      result = page.css('.ac-result').first
      link_url = result.css('.ac-vehicle__title a')[0]["href"]
      follow_me = "https://www.arnoldclark.com#{link_url}"
      page = Nokogiri::HTML(open(follow_me))
      puts page.css('.ac-vehicle__title').text
    end

    def self.url
      <<~URL
        https://www.arnoldclark.com/used-cars/search?
        search_type=Used%20Cars&
        payment_type=cash&
        max_price=10000&
        distance=50&
        photos_only=true&
        unreserved_only=true&
        transmission=Manual&
        mpg=50&
        mileage=30000&
        age=2&
        min_engine_size=1545&
        body_type%5B%5D=Estate&
        body_type%5B%5D=SUV&
        body_type%5B%5D=People%20carrier&
        body_type%5B%5D=Saloon&
        body_type%5B%5D=Hatchback&
        sort_order=price_up
      URL
    end
  end
end
