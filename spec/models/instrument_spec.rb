require 'rails_helper'

RSpec.describe Instrument, type: :model do
  describe 'Validation' do
    describe 'Factory check' do
      subject { build(:instrument) }

      it { is_expected.to be_valid }
    end

    describe 'Presence validation' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:color) }
    end

    describe 'Uniqueness validation' do
      subject { create(:instrument) }

      it { is_expected.to validate_uniqueness_of(:name) }
    end

    describe 'Format validation' do
      subject { build(:instrument, color: 'dummy') }

      it '16進トリプレット表記のカラーコードでないなら、invalidである' do
        expect(subject).to be_invalid
      end
    end
  end
end
