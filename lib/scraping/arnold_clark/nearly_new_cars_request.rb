module Scraping
  module ArnoldClark
    class NearlyNewCarsRequest < CarsRequest
      def cache_key
        'nearly_new_car_index'
      end

      def url
        <<~URL
          https://www.arnoldclark.com/used-cars/search?
          search_type=Nearly%20New%20Cars&
          payment_type=cash&
          max_price=12000&
          location=Edinburgh%20EH17%2C%20UK&
          distance=100&
          photos_only=true&
          unreserved_only=true&
          transmission=Manual&
          mpg=50&
          min_engine_size=1545&
          body_type%5B%5D=Hatchback&
          body_type%5B%5D=Estate&
          body_type%5B%5D=Saloon&
          body_type%5B%5D=SUV&
          body_type%5B%5D=People%20carrier&
          doors%5B%5D=5&
          sort_order=price_up
        URL
      end
    end
  end
end
