require_relative '../../lib/scraping/arnold_clark/used_cars'

class CarsController < ApplicationController
  def used
    @number_of_cars = params[:max].to_i
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
