require_relative '../../lib/scraping/arnold_clark/cars'
require_relative '../../lib/scraping/arnold_clark/used_cars_request'
require_relative '../../lib/scraping/arnold_clark/nearly_new_cars_request'

class CarsController < ApplicationController
  def by_type
    result = {
      used_cars: car_lists.used,
      nearly_new_cars: car_lists.nearly_new
    }
    render json: result
  end

  def for_data_processing
    render json: car_lists.for_data_processing
  end

  private

  def number_of_cars
    @number_of_cars = (params[:max] || 5).to_i
  end

  def car_lists
    @car_lists ||= CarListsGenerator.new(number_of_cars)
  end
end
