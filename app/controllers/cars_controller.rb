require_relative '../../lib/scraping/arnold_clark/cars'
require_relative '../../lib/scraping/arnold_clark/used_cars_request'
require_relative '../../lib/scraping/arnold_clark/nearly_new_cars_request'

class CarsController < ApplicationController
  def used
    @number_of_cars = (params[:max] || 5).to_i
    render json: result
  end

  private

  attr_reader :number_of_cars

  def result
    { used_cars: used_cars, nearly_new_cars: nearly_new_cars }
  end

  def used_cars
    Scraping::ArnoldClarkCars.call(
      number_of_cars: number_of_cars,
      car_request: Scraping::ArnoldClarkUsedCarsRequest
    )
  end

  def nearly_new_cars
    Scraping::ArnoldClark::Cars.call(
      number_of_cars: number_of_cars,
      car_request: Scraping::ArnoldClarkNearlyNewCarsRequest
    )
  end
end
