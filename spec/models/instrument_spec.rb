require 'rails_helper'

RSpec.describe Instrument, type: :model do
  describe 'Association' do
    it { is_expected.to have_many(:performers) }
  end

  describe 'Validation' do
    describe 'Factory check' do
      it { expect(build(:instrument)).to be_valid }
    end

    describe 'Presence' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:color) }
    end

    describe 'Uniqueness' do
      subject { create(:instrument) }

      it { is_expected.to validate_uniqueness_of(:name) }
    end

    describe 'Length' do
      it { is_expected.to validate_length_of(:name).is_at_most(255) }
    end

    describe 'Format' do
      let(:instrument) { build(:instrument, color: 'dummy') }

      it 'カラーコードでないならinvalidである' do
        expect(instrument).to be_invalid
      end
    end
  end
end
