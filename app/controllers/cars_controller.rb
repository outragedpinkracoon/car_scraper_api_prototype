require_relative '../../lib/scraping/arnold_clark/cars'
require_relative '../../lib/scraping/arnold_clark/used_cars_request'
require_relative '../../lib/scraping/arnold_clark/nearly_new_cars_request'

class CarsController < ApplicationController
  def by_type
    @number_of_cars = (params[:max] || 5).to_i
    result = { used_cars: results[0], nearly_new_cars: results[1] }
    render json: result
  end

  def for_data_processing
    @number_of_cars = (params[:max] || 5).to_i

    tagged_used = update_fields(results[0], 'used')
    tagged_nearly_new = update_fields(results[1], 'nearly-new')

    result = tagged_used + tagged_nearly_new

    render json: result
  end

  private

  attr_reader :number_of_cars

  def update_fields(car_set, tag_name)
    car_set.pmap do |item|
      item[:category] = tag_name
      item[:score] = ''
      item
    end
  end

  def results
    @results ||= [
      Scraping::ArnoldClark::UsedCarsRequest,
      Scraping::ArnoldClark::NearlyNewCarsRequest
    ].pmap do |request_type|
      Scraping::ArnoldClark::Cars.call(
        number_of_cars: number_of_cars,
        car_request: request_type
      )
    end
  end
end
