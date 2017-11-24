class CarListsGenerator
  def initialize(number_of_cars)
    @number_of_cars = number_of_cars
  end

  def used
    scraping_results[0]
  end

  def nearly_new
    scraping_results[1]
  end

  def for_data_processing
    tagged_used = update_fields(used, 'used')
    tagged_nearly_new = update_fields(nearly_new, 'nearly-new')

    tagged_used + tagged_nearly_new
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

  def scraping_results
    @scraping_results ||= [
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
