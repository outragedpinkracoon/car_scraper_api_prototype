require 'net/http'

module Scraping
  class ArnoldClark
    def self.call
      uri = URI(url)
      req = Net::HTTP.get(uri)
      nil
    end

    def self.url
      'https://www.arnoldclark.com/used-cars/search?'\
      'search_type=Used%20Cars&'\
      'payment_type=cash&'\
      'max_price=10000&'\
      'distance=50&'\
      'photos_only=true&'\
      'unreserved_only=true&'\
      'transmission=Manual&'\
      'mpg=50&'\
      'mileage=30000&'\
      'age=2&'\
      'min_engine_size=1545&'\
      'body_type%5B%5D=Estate&'\
      'body_type%5B%5D=SUV&'\
      'body_type%5B%5D=People%20carrier&'\
      'body_type%5B%5D=Saloon&'\
      'body_type%5B%5D=Hatchback&'\
      'sort_order=price_up'
    end
  end
end
