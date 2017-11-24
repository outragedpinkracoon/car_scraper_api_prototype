require_relative 'car'

module Scraping
  module ArnoldClark
    class Cars
      extend Callable

      def initialize(number_of_cars:, car_request:)
        @indices = (0..number_of_cars - 1).to_a
        @car_request = car_request
      end

      def call
        indices.to_a.pmap do |index|
          scraping_result = car_request.send(:call, car_index: index)
          Car.call(
            car_html_document: scraping_result[:html_document],
            car_page_link: scraping_result[:href]
          )
        end
      end

      private

      attr_reader :indices, :car_request
    end
  end
end
