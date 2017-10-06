require 'net/http'
require 'open-uri'
require_relative '../common/callable'

module Scraping
  class ArnoldClark
    extend Callable

    def call
      [
        {
          model: car_model
        }
      ]
    end

    private

    def first_car_html
      index_page.css('.ac-result').first
    end

    def car_model
      parts = title.split(' ')
      last_index = parts.length - 1
      parts[2..last_index].join(' ')
    end

    def index_page
      @index_page ||= Nokogiri::HTML(open(url))
    end

    def car_page_link
      link = first_car_html.css('.ac-vehicle__title a')[0]['href']
      "https://www.arnoldclark.com#{link}"
    end

    def car_page
      @car_page ||= Nokogiri::HTML(open(car_page_link))
    end

    def full_title
      car_page.css('.ac-vehicle__title').text
    end

    def title
      full_title.sub(subtitle, '')
    end

    def subtitle
      car_page.css('.ac-vehicle__title-variant').text
    end

    def url
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
