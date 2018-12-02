require 'rails_helper'

RSpec.describe Instrument, type: :model do
  describe 'Validation tests' do
    let(:instrument) { build(:instrument) }

    it 'factoryが正常に動作する' do
      expect(instrument).to be_valid
    end

    describe 'Standard Validation' do
      it 'nameがないとinvalidである' do
        instrument.name = ''
        expect(instrument).to be_invalid
      end

      it 'colorがないとinvalidである' do
        instrument.color = ''
        expect(instrument).to be_invalid
      end

      it 'colorがカラーコードを示す文字列でないとinvalidである' do
        instrument.color = 'dummy'
        expect(instrument).to be_invalid
      end
    end
  end
end
