require 'rails_helper'
require 'vcr'

RSpec.describe CarsController, type: :controller do
  describe '#index' do

    it 'is successful' do
      VCR.use_cassette('arnold_clark_used_cars') do
        get :index
        expect(response).to be_successful
      end
    end

    xit 'returns a list of used cars' do
      get :index
      expected_response = {
        'data' =>  {
          'cars' =>  [
            {
              'make' => 'fiat',
              'model' => 'panda',
              'price' => 6000,
              'mileage' => 5000,
              'engine' => '1.6 tdi',
              'year' => 2015
            },
            {
              'make' => 'fiat',
              'model' => 'panda',
              'price' => 7000,
              'mileage' => 5000,
              'engine' => '1.6 tdi',
              'year' => 2015
            },
            {
              'make' => 'fiat',
              'model' => 'panda',
              'price' => 8000,
              'mileage' => 5000,
              'engine' => '1.6 tdi',
              'year' => 2015
            },
            {
              'make' => 'fiat',
              'model' => 'panda',
              'price' => 9000,
              'mileage' => 5000,
              'engine' => '1.6 tdi',
              'year' => 2015
            },
            {
              'make' => 'fiat',
              'model' => 'panda',
              'price' => 1000, 'mileage' => 5000,
              'engine' => '1.6 tdi',
              'year' => 2015
            }
          ]
        }
      }
      expect(response_body).to eq(expected_response)
    end
    def response_body
      JSON.parse(response.body)
    end
  end
end
