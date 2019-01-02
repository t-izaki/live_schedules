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

    describe 'Presence' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:instrument_id) }
    end

    describe 'Length' do
      it { is_expected.to validate_length_of(:name).is_at_most(255) }
    end

    describe 'Format' do
      describe ':icon_url' do
        it { is_expected.to allow_value('http://foo.com').for(:icon_url) }
        it { is_expected.to allow_value('https://foo.com').for(:icon_url) }
        it { is_expected.not_to allow_value('hogehoge').for(:icon_url) }
        it { is_expected.to allow_value('').for(:icon_url) }
      end

      describe ':image_url' do
        it { is_expected.to allow_value('http://foo.com').for(:image_url) }
        it { is_expected.to allow_value('https://foo.com').for(:image_url) }
        it { is_expected.not_to allow_value('hogehoge').for(:image_url) }
        it { is_expected.to allow_value('').for(:image_url) }
      end
    end
  end
end
