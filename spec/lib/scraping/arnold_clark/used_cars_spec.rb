require_relative '../../../../lib/scraping/arnold_clark/used_cars'

RSpec.describe Scraping::ArnoldClark::UsedCars do
  let(:subject) { described_class.call.first }

  it 'returns the car model' do
    VCR.use_cassette('arnold_clark_used_cars') do
      VCR.use_cassette('specific_used_car') do
        expect(subject[:model]).to eq('Citroen C3 Picasso')
      end
    end
  end
end
