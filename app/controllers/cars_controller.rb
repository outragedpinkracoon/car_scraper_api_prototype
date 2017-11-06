require_relative '../../lib/scraping/arnold_clark/used_cars'

class CarsController < ApplicationController
  def used
    # TODO: How to have a default for max?
    # TODO: Only hit the index page once
    @number_of_cars = params[:max].to_i || 5
    render json: result
  end

  private

  attr_reader :number_of_cars

  def result
    { used_cars: used_cars }
  end

  def used_cars
    Scraping::ArnoldClark::UsedCars.call number_of_cars: number_of_cars
  end
end
