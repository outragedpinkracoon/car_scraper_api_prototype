require 'rails_helper'
require 'vcr'

RSpec.describe CarsController, type: :controller do
  describe '#index' do
    it 'is successful' do
      VCR.use_cassette('used_car_list') do
        get :index
        expect(response).to be_successful
      end
    end

    it 'returns a list of used cars' do
      VCR.use_cassette('used_car_list') do
        get :index

        expected_response = {
          'used_cars' =>  [
            {
              'model' => 'Peugeot 2008',
              'year' => '2015',
              'engine_litres' => 1.6,
              'gearbox_type' => 'Manual',
              'mpg' => 76.3,
              'price' => 8698
            },
            {
              'model' => 'Citroen C4 Cactus',
              'year' => '2016',
              'engine_litres' => 1.6,
              'gearbox_type' => 'Manual',
              'mpg' => 80.7,
              'price' => 8998
            }
          ]
        }
        expect(response_body).to eq(expected_response)
      end
    end

    def response_body
      JSON.parse(response.body)
    end
  end
end
