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
        indices.to_a.map do |index|
          car_page_info = car_request.send(:call, index)
          Car.call(car_page_info)
        end
      end

      private

      attr_reader :indices, :car_request
    end
  end
end
