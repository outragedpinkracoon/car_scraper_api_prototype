module Scraping
  module ArnoldClark
    class CarHTML
      def initialize(car_index:)
        @car_index = car_index
      end

      def product_summary
        @product_summary ||= car_page.css('.ac-product__summary')
      end

      def title_parts
        @title_parts ||= title.split(' ')
      end

      def title
        @title ||= full_title.sub(subtitle, '')
      end

      def full_title
        @full_title ||= car_page.css('.ac-vehicle__title').text
      end

      def subtitle
        @subtitle ||= car_page.css('.ac-vehicle__title-variant').text
      end

      def image_thumbnail
        @image ||= car_page.css('.ac-imagethumbnail img').attribute('src').value
      end

      def search_product_summary(text)
        result = product_summary.xpath(
          "//th[text()='#{text}']/following-sibling::td/text()[1]"
        )
        result[0].text
      end

      def price
        car_page.css('.ac-money')
      end

      private

      attr_reader :car_index

      def car_page
        @car_page ||= UsedCarsRequest.call(car_index || 0)
      end
    end
  end
end
