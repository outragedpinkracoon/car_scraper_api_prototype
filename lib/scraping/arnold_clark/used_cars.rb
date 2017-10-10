require 'net/http'
require 'open-uri'

require_relative '../../common/callable'
require_relative 'used_cars_request'
require_relative 'car_html'

module Scraping
  module ArnoldClark
    class UsedCars
      extend Callable
      include CarHTML

      def call
        [
          {
            model: car_model,
            year: car_year,
            engine_cc: car_engine_cc,
            engine_litres: car_engine_litres,
            gearbox_type: car_gearbox_type,
            mpg: car_mpg,
            price: car_price
          }
        ]
      end

      private

      def car_price
        price[0].text.sub('£', '').to_i
      end

      def car_model
        last_index = title_parts.length - 1
        title_parts[2..last_index].join(' ')
      end

      def car_year
        title_parts[0]
      end

      def car_engine_cc
        engine_node = search_product_summary('Engine')
        engine_node.sub('cc', '').to_i
      end

      def car_gearbox_type
        search_product_summary('Gears')
      end

      def car_mpg
        search_product_summary('MPG (combined)').to_f
      end

      def car_engine_litres
        (car_engine_cc.to_f / 1000).round(1)
      end
    end
  end
end
