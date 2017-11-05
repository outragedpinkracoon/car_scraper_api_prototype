require_relative '../../lib/scraping/arnold_clark/used_cars'

class CarsController < ApplicationController
  def index
    render json: result
  end

  def result
    {
      used_cars: Scraping::ArnoldClark::UsedCars.call(number_of_cars: 2)
    }
  end
end
