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
                  model: 'Citroen C3 Picasso',
                  year: '2016',
                  engine_litres: 1.6,
                  gearbox_type: 'Manual',
                  mpg: 72.4,
                  price: 7698
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
