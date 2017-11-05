require 'nokogiri'

module Scraping
  module ArnoldClark
    class UsedCarsRequest
      extend Callable

      def initialize(car_index)
        @car_index = car_index
      end

      def call
        request_car_page
      end

      private

      attr_reader :car_index

      def request_car_page
        @car_page ||= Nokogiri::HTML(
          open(
            car_page_link
          )
        )
      end

      def car_page_link
        path = car_html.css('.ac-vehicle__title a')[0]['href']
        "https://www.arnoldclark.com#{path}"
      end

      def car_html
        index_page.css('.ac-result')[1]
      end

      def index_page
        @index_page ||= Nokogiri::HTML(open(url))
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
end
