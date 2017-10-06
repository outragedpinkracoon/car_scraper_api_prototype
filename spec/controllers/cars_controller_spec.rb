require 'rails_helper'
require 'vcr'

RSpec.describe CarsController, type: :controller do
  describe '#index' do
    it 'is successful' do
      VCR.use_cassette('arnold_clark_used_cars') do
        VCR.use_cassette('specific_used_car') do
          get :index
          expect(response).to be_successful
        end
      end
    end

    xit 'returns a list of used cars' do
      VCR.use_cassette('arnold_clark_used_cars') do
        VCR.use_cassette('specific_used_car') do
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
                }
              ]
            }
          }
          expect(response_body).to eq(expected_response)
        end
      end
    end

    def response_body
      JSON.parse(response.body)
    end
  end
end
