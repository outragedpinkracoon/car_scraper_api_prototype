module Scraping
  module ArnoldClark
    module CarHTML
      def product_summary
        @product_summary ||= car_html.css('.ac-product__summary')
      end

      def title_parts
        @title_parts ||= title.split(' ')
      end

      def title
        @title ||= full_title.sub(subtitle, '')
      end

      def full_title
        @full_title ||= car_html.css('.ac-vehicle__title').text
      end

      def subtitle
        @subtitle ||= car_html.css('.ac-vehicle__title-variant').text
      end

      private

      def car_html
        @car_html ||= UsedCarsRequest.call
      end
    end
  end
end
