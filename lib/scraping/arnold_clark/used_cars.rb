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
            model: car_model,
            year: car_year,
            engine_cc: car_engine_cc,
            engine_litres: car_engine_litres
          }
        ]
      end

      private

      def car_model
        last_index = title_parts.length - 1
        title_parts[2..last_index].join(' ')
      end

      def car_year
        title_parts[0]
      end

      def car_engine_cc
        engine_node = product_summary.xpath(
          "//th[text()='Engine']/following-sibling::td/text()[1]"
        )
        engine_node.text.sub('cc', '').to_i
      end

      def car_engine_litres
        (car_engine_cc.to_f / 1000).round(1)
      end

      def product_summary
        car_html.css('.ac-product__summary')
      end

      def title_parts
        @title_parts ||= title.split(' ')
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
