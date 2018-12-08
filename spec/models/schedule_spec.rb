require 'rails_helper'

RSpec.describe Schedule, type: :model do
  describe 'enum' do
    describe 'state' do
      it { expect(build(:schedule, state: 0).state).to eq 'undecided' }
      it { expect(build(:schedule, state: 1).state).to eq 'open' }
      it { expect(build(:schedule, state: 2).state).to eq 'closed' }
      it 'stateがenumで指定されたintegerでないとinvalidである' do
        expect { build(:schedule, state: 999) }.to raise_error(ArgumentError)
      end
    end
  end

  describe 'Validation' do
    describe 'Factory check' do
      it { expect(build(:schedule)).to be_valid }
    end

    describe 'Presence' do
      it { is_expected.to validate_presence_of(:date) }
      it { is_expected.to validate_presence_of(:state) }
    end

    describe 'Uniqueness' do
      subject { create(:schedule) }

      it { is_expected.to validate_uniqueness_of(:date) }
    end

    describe 'Length' do
      it { is_expected.to validate_length_of(:title).is_at_most(255) }
    end

    # describe 'Numericality' do
    #  # describe 'enum' のテストで確認しているため省略
    # end
  end
end
