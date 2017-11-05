require 'rails_helper'
require 'vcr'

RSpec.describe CarsController, type: :controller do
  describe '#index' do
    let(:perform) { get :used, params: { 'max' => '2' } }

    it 'is successful' do
      wrap_vcr do
        perform
        expect(response).to be_successful
      end
    end

    it 'returns a list of used cars' do
      wrap_vcr do
        perform

        expected_response = {
          'used_cars' =>  [
            {
              'model' => 'Peugeot 2008',
              'year' => '2015',
              'engine_litres' => 1.6,
              'mpg' => 76.3,
              'price' => 8698
            },
            {
              'model' => 'Citroen C4 Cactus',
              'year' => '2016',
              'engine_litres' => 1.6,
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

    def wrap_vcr
      VCR.use_cassette('used_car_list') do
        yield
      end
    end
  end
end
