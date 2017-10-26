require_relative '../../lib/scraping/arnold_clark/used_cars'

class CarsController < ApplicationController
  def index
    render json: result
  end

  def result

  end
end
