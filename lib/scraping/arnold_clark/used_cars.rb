require 'net/http'
require 'open-uri'

require_relative '../../common/callable'
require_relative 'used_cars_request'

module Scraping
  module ArnoldClark
    class UsedCars
      extend Callable

      def call
        [
          {
            model: car_model
          }
        ]
      end

      private

      def car_model
        parts = title.split(' ')
        last_index = parts.length - 1
        parts[2..last_index].join(' ')
      end

      def title
        full_title.sub(subtitle, '')
      end

      def full_title
        car_html.css('.ac-vehicle__title').text
      end

      def subtitle
        car_html.css('.ac-vehicle__title-variant').text
      end

      def car_html
        @car_html ||= UsedCarsRequest.call
      end
    end
  end
end
