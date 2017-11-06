require_relative '../../../../lib/scraping/arnold_clark/used_car'

RSpec.describe Scraping::ArnoldClark::UsedCar do
  let(:subject) { described_class.call(car_index: 0) }

  it 'returns the car model' do
    wrap_vcr do
      expect(subject[:model]).to eq('Peugeot 2008')
    end
  end

  it 'returns the car year' do
    wrap_vcr do
      expect(subject[:year]).to eq('2015')
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
