require_relative 'used_car'

module Scraping
  module ArnoldClark
    class UsedCars
      extend Callable

      def initialize(number_of_cars:)
        @indices = (0..number_of_cars - 1).to_a
      end

      def call
        Parallel.map(indices.to_a) do |index|
          UsedCar.call(car_index: index)
        end
      end

      private

      attr_reader :indices
    end
  end
end
