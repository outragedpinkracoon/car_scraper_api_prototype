require_relative '../../common/callable'

module Scraping
  module ArnoldClark
    class Car
      extend Callable

      def initialize(car_html_document:, car_page_link:)
        @car_html_document = car_html_document
        @car_page_link = car_page_link
      end

      def call # rubocop:disable Metrics/MethodLength
        {
          make: car_make,
          model: car_model,
          year: car_year,
          engine_litres: car_engine_litres,
          mpg: car_mpg,
          mileage: car_mileage,
          price: car_price,
          image: car_image,
          href: car_page_link
        }
      end

      private

      attr_reader :car_html_document, :car_page_link

      def car_price
        price = car_html_document.css('.ac-money')[0]
        price.text.sub('£', '').sub(',', '').to_i
      end

      def car_make_and_model
        last_index = title_parts.length - 1
        text = title_parts[2..last_index].join(' ')
        parts = text.split(' ')
        {
          make: parts[0],
          model: parts[1..parts.length - 1].join(' ')
        }
      end

      def car_year
        title_parts[0]
      end

      def car_model
        car_make_and_model[:model]
      end

      def car_make
        car_make_and_model[:make]
      end

      def car_engine_cc
        engine_node = search_product_summary('Engine')
        engine_node.sub('cc', '').to_i
      end

      def car_mpg
        search_product_summary('MPG (combined)').to_f
      end

      def car_engine_litres
        (car_engine_cc.to_f / 1000).round(1)
      end

      def car_image
        car_html_document.css('.ac-imagethumbnail img').attribute('src').value
      end

      def car_mileage
        search_product_summary('Mileage').to_i
      end

      def product_summary
        @product_summary ||= car_html_document.css('.ac-product__summary')
      end

      def title_parts
        @title_parts ||= title.split(' ')
      end

      def title
        subtitle = car_html_document.css('.ac-vehicle__title-variant').text
        full_title = car_html_document.css('.ac-vehicle__title').text
        full_title.sub(subtitle, '')
      end

      def search_product_summary(text)
        result = product_summary.xpath(
          "//th[text()='#{text}']/following-sibling::td/text()[1]"
        )
        result[0].text
      end
    end
  end
end
