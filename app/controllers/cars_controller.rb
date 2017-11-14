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
    results = [
      Scraping::ArnoldClark::UsedCarsRequest,
      Scraping::ArnoldClark::NearlyNewCarsRequest
    ].pmap do |request_type|
      Scraping::ArnoldClark::Cars.call(
        number_of_cars: number_of_cars,
        car_request: request_type
      )
    end
    { used_cars: results[0], nearly_new_cars: results[1] }
  end
end
