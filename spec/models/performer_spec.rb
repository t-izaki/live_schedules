require 'rails_helper'

RSpec.describe Performer, type: :model do
  describe 'Association' do
    it { is_expected.to belong_to(:instrument) }
  end

  describe 'Validation' do
    describe 'Factory check' do
      it { expect(build(:performer)).to be_valid }
      it { expect(build(:performer, :blank_introduction)).to be_valid }
    end

    describe 'Presence validation' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:instrument_id) }
    end

    describe 'Numericality validation' do
      it { is_expected.to validate_numericality_of(:instrumnet_id) }
    end
  end
end
