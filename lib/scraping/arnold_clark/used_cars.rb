require 'net/http'
require 'open-uri'

require_relative '../../common/callable'
require_relative 'used_cars_request'
require_relative 'car_html'

module Scraping
  module ArnoldClark
    class UsedCars
      extend Callable
      # rubocop:disable Metrics/MethodLength
      def call
        [
          {
            model: car_model,
            year: car_year,
            engine_litres: car_engine_litres,
            gearbox_type: car_gearbox_type,
            mpg: car_mpg,
            price: car_price
          }
        ]
      end
      # rubocop:enable Metrics/MethodLength

      private

      attr_reader :car_html

      def car_price
        car_html.price[0].text.sub('£', '').to_i
      end

      def car_model
        last_index = car_html.title_parts.length - 1
        car_html.title_parts[2..last_index].join(' ')
      end

      def car_year
        car_html.title_parts[0]
      end

      def car_engine_cc
        engine_node = car_html.search_product_summary('Engine')
        engine_node.sub('cc', '').to_i
      end

      def car_gearbox_type
        car_html.search_product_summary('Gears')
      end

      def car_mpg
        car_html.search_product_summary('MPG (combined)').to_f
      end

      def car_engine_litres
        (car_engine_cc.to_f / 1000).round(1)
      end

      def car_html
        @car_html ||= CarHTML.new
      end
    end
  end
end
