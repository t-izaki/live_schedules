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

    # describe 'Inclusion' do
    #  # describe 'enum' のテストで確認しているため省略
    # end
  end

  describe 'Scope' do
    describe ':select_in_month' do
      subject { Schedule.select_in_month(Date.new(2018, 1, 1)) }

      before do
        create(:schedule, date: '2017-12-31')
        create(:schedule, date: '2018-02-01')
      end

      let!(:schedule_1_20) { create(:schedule, date: '2018-01-20') }
      let!(:schedule_1_10) { create(:schedule, date: '2018-01-10') }

      it '指定された日付の月のスケジュールのリストを日付の昇順で返す' do
        is_expected.to eq [schedule_1_10, schedule_1_20]
      end
    end
  end

  describe 'Method' do
    describe 'self.select_or_create_in_month' do
      subject { Schedule.select_or_create_in_month(Date.new(2018, 1, 1)) }

      let!(:schedule_1_10) { create(:schedule, date: '2018-01-10') }
      let!(:schedule_1_20) { create(:schedule, date: '2018-01-20') }

      it '指定された日付の月に存在するスケジュールを返す' do
        is_expected.to include(schedule_1_10, schedule_1_20)
      end
      it '指定された日付の月にスケジュールが存在しない日がある場合は、新しく作成する' do
        is_expected_block.to change(Schedule, :count).from(2).to(31)
      end
    end
  end
end
