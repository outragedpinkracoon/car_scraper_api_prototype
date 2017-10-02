require_relative '../../lib/scraping/arnold_clark'

class CarsController < ApplicationController
  def index
    render json: result
  end

  def result
    Scraping::ArnoldClark.call
  end
end
