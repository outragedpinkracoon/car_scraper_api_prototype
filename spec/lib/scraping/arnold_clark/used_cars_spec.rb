require_relative '../../../../lib/scraping/arnold_clark/used_cars'

RSpec.describe Scraping::ArnoldClark::UsedCars do
  let(:subject) { described_class.call.first }

  it 'returns the car model' do
    wrap_vcr do
      expect(subject[:model]).to eq('Citroen C3 Picasso')
    end
  end

  it 'returns the car year' do
    wrap_vcr do
      expect(subject[:year]).to eq('2016')
    end
  end

  describe 'car engine size' do
    it 'returns the car engine size in litres' do
      wrap_vcr do
        expect(subject[:engine_litres]).to eq(1.6)
      end
    end

    it 'returns the car engine size in cc' do
      wrap_vcr do
        expect(subject[:engine_cc]).to eq(1560)
      end
    end
  end

  def wrap_vcr
    VCR.use_cassette('arnold_clark_used_cars') do
      VCR.use_cassette('specific_used_car') do
        yield
      end
    end
  end

end
