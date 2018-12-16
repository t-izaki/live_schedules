require 'rails_helper'

describe 'MonthlySchedules', type: :feature do
  before do
    admin = create(:admin)
    login_as(admin, scope: :admin)
  end

  describe '#show' do
    before do
      create(:simple_open_schedule, date: '2018-01-10', title: 'ピアノ演奏会')
      create(:simple_undecided_schedule, date: '2018-01-20', detail: '未定')
    end

    it 'monthly_schedulesが表示できる' do
      visit '/monthly_schedules/2018-01-01'
      expect(page).to have_http_status(:success)
      expect(page).to have_content('2018-01-10 水 open ピアノ演奏会')
      expect(page).to have_content('2018-01-20 土 undecided 未定')
    end
  end

  describe '#edit->#update' do
    let!(:schedule_1_10) { create(:simple_open_schedule, date: '2018-01-10', title: 'ピアノ演奏会') }
    let!(:schedule_1_20) { create(:simple_undecided_schedule, date: '2018-01-20', detail: '未定') }

    it 'monthly_schedulesが更新できる' do
      visit '/monthly_schedules/2018-01-01/edit'

      fill_in "schedule_#{schedule_1_10.id}_title", with: 'バイオリン演奏会'
      fill_in "schedule_#{schedule_1_10.id}_detail", with: 'ピアノからバイオリンに変更'
      select 'closed', from: "schedule_#{schedule_1_20.id}_state"
      fill_in "schedule_#{schedule_1_20.id}_detail", with: ''
      click_on '更新する'

      expect(page).to have_http_status(:success)
      expect(page).to have_content('2018-01-10 水 open バイオリン演奏会 ピアノからバイオリンに変更')
      expect(page).to have_content('2018-01-20 土 closed')
    end
  end
end
