require 'rails_helper'

require_relative '../../../../lib/scraping/arnold_clark/car'
require_relative '../../../../lib/scraping/arnold_clark/used_cars_request'

RSpec.describe Scraping::ArnoldClark::Car do
  let(:scraping_result) {
    Scraping::ArnoldClark::UsedCarsRequest.call(car_index: 0)
  }

  let(:subject) do
    VCR.use_cassette 'used_car_list' do
      described_class.call(
        car_html_document: scraping_result[:html_document],
        car_page_link: scraping_result[:href]
      )
    end
  end

  it 'returns the car model' do
    wrap_vcr do
      expect(subject[:model]).to eq('2008')
    end
  end

  it 'returns the car make' do
    wrap_vcr do
      expect(subject[:make]).to eq('Peugeot')
    end
  end

  it 'returns the car year' do
    wrap_vcr do
      expect(subject[:year]).to eq('2015')
    end
  end

  it 'returns the link to the car' do
    wrap_vcr do
      expect(subject[:href]).to eq(
        'https://www.arnoldclark.com/used-cars/peugeot/2008/1-6-bluehdi-75-active-5dr/2015/ref/arnel-u-567052'
      )
    end
  end

  it 'returns the car price' do
    wrap_vcr do
      expect(subject[:price]).to eq(8698)
    end
  end

  it 'returns the car mpg' do
    wrap_vcr do
      expect(subject[:mpg]).to eq(76.3)
    end
  end

  it 'returns the car mileage' do
    wrap_vcr do
      expect(subject[:mileage]).to eq(23_125)
    end
  end

  it 'returns the car image' do
    wrap_vcr do
      expect(subject[:image]).to eq('https://vcache.arnoldclark.com/imageserver/AKRENOE5L6-VUK5/800/f')
    end
  end

  describe 'car engine size' do
    it 'returns the car engine size in litres' do
      wrap_vcr do
        expect(subject[:engine_litres]).to eq(1.6)
      end
    end
  end

  def wrap_vcr
    VCR.use_cassette('specific_used_car_0') do
      yield
    end
  end
end
