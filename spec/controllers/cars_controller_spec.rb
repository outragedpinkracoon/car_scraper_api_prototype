require 'rails_helper'
require 'vcr'

RSpec.describe CarsController, type: :controller do
  describe '#by_type' do
    let(:perform) { get :by_type, params: { 'max' => '2' } }

    it 'is successful' do
      wrap_vcr do
        perform
        expect(response).to be_successful
      end
    end

    it 'returns a list of cars in the correct format' do
      wrap_vcr do
        perform

        expected_response = {
          'used_cars' =>  [
            {
              'make' => 'Peugeot',
              'model' => '2008',
              'year' => '2015',
              'engine_litres' => 1.6,
              'mpg' => 76.3,
              'mileage' => 23_125,
              'price' => 8698,
              'image' => 'https://vcache.arnoldclark.com/imageserver/AKRENOE5L6-VUK5/800/f',
              'href' => 'https://www.arnoldclark.com/used-cars/peugeot/2008/1-6-bluehdi-75-active-5dr/2015/ref/arnel-u-567052'
            },
            {
              'make' => 'Citroen',
              'model' => 'C4 Cactus',
              'year' => '2016',
              'engine_litres' => 1.6,
              'mpg' => 80.7,
              'mileage' => 17_129,
              'price' => 8798,
              'image' => 'https://vcache.arnoldclark.com/imageserver/ALRKNZH6D1-GUL2/800/f',
              'href' => 'https://www.arnoldclark.com/used-cars/citroen/c4-cactus/1-6-bluehdi-flair-5dr/2016/ref/arnhd-u-22248'
            }
          ],
          'nearly_new_cars' =>  [
            {
              'make' => 'Citroen',
              'model' => 'C4 Cactus',
              'year' => '2017',
              'engine_litres' => 1.6,
              'mpg' => 78.5,
              'mileage' => 18_589,
              'price' => 9298,
              'image' => 'https://vcache.arnoldclark.com/imageserver/APRWNFH6A6-JUK2/800/f',
              'href' => 'https://www.arnoldclark.com/nearly-new-cars/citroen/c4-cactus/1-6-bluehdi-feel-5dr-non-start-stop/2017/ref/arnha-u-22707'
            },
            {
              'make' => 'Peugeot',
              'model' => '208',
              'year' => '2016',
              'engine_litres' => 1.6,
              'mpg' => 80.7,
              'mileage' => 16_529,
              'price' => 9498,
              'image' => 'https://vcache.arnoldclark.com/imageserver/ALRDNFA6S6-SUK5/800/f',
              'href' => 'https://www.arnoldclark.com/nearly-new-cars/peugeot/208/1-6-bluehdi-100-allure-5dr-non-start-stop/2016/ref/arnas-u-57724'
            }
          ]
        }
        expect(response_body).to eq(expected_response)
      end
    end
  end

  describe '#for_data_processing' do
    let(:perform) { get :for_data_processing, params: { 'max' => '2' } }

    it 'is successful' do
      wrap_vcr do
        perform
        expect(response).to be_successful
      end
    end

    it 'returns a list of cars in the correct format' do
      wrap_vcr do
        perform

        expected_response = [
          {
            'make' => 'Peugeot',
            'model' => '2008',
            'year' => '2015',
            'engine_litres' => 1.6,
            'mpg' => 76.3,
            'mileage' => 23_125,
            'price' => 8698,
            'image' => 'https://vcache.arnoldclark.com/imageserver/AKRENOE5L6-VUK5/800/f',
            'href' => 'https://www.arnoldclark.com/used-cars/peugeot/2008/1-6-bluehdi-75-active-5dr/2015/ref/arnel-u-567052',
            'category' => 'used',
            'score' => ''
          },
          {
            'make' => 'Citroen',
            'model' => 'C4 Cactus',
            'year' => '2016',
            'engine_litres' => 1.6,
            'mpg' => 80.7,
            'mileage' => 17_129,
            'price' => 8798,
            'image' => 'https://vcache.arnoldclark.com/imageserver/ALRKNZH6D1-GUL2/800/f',
            'href' => 'https://www.arnoldclark.com/used-cars/citroen/c4-cactus/1-6-bluehdi-flair-5dr/2016/ref/arnhd-u-22248',
            'category' => 'used',
            'score' => ''
          },
          {
            'make' => 'Citroen',
            'model' => 'C4 Cactus',
            'year' => '2017',
            'engine_litres' => 1.6,
            'mpg' => 78.5,
            'mileage' => 18_589,
            'price' => 9298,
            'image' => 'https://vcache.arnoldclark.com/imageserver/APRWNFH6A6-JUK2/800/f',
            'href' => 'https://www.arnoldclark.com/nearly-new-cars/citroen/c4-cactus/1-6-bluehdi-feel-5dr-non-start-stop/2017/ref/arnha-u-22707',
            'category' => 'nearly-new',
            'score' => ''
          },
          {
            'make' => 'Peugeot',
            'model' => '208',
            'year' => '2016',
            'engine_litres' => 1.6,
            'mpg' => 80.7,
            'mileage' => 16_529,
            'price' => 9498,
            'image' => 'https://vcache.arnoldclark.com/imageserver/ALRDNFA6S6-SUK5/800/f',
            'href' => 'https://www.arnoldclark.com/nearly-new-cars/peugeot/208/1-6-bluehdi-100-allure-5dr-non-start-stop/2016/ref/arnas-u-57724',
            'category' => 'nearly-new',
            'score' => ''
          }
        ]
        expect(response_body).to eq(expected_response)
      end
    end
  end

  def response_body
    JSON.parse(response.body)
  end

  def wrap_vcr
    VCR.use_cassette('car_lists') do
      yield
    end
  end
end
