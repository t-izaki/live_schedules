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
    describe 'monthly_schedulesが更新できる' do
      let(:schedule) do
        create(:schedule, :open, :with_performer,
               date: '2018-01-10', title: 'ピアノ演奏会', detail: 'ピアノの演奏会です')
      end
      let!(:performer_name) { schedule.performers.first.name }
      let!(:new_performer_name) { create(:performer).name }

      before { visit '/monthly_schedules/2018-01-01/edit' }

      it '更新なし' do
        click_on '更新する'
        expect(page).to have_http_status(:success)
        expect(page).to have_content("2018-01-10 水 open #{performer_name} ピアノ演奏会 ピアノの演奏会です")
      end

      it '状態が更新できる' do
        select 'closed', from: "schedule_#{schedule.id}_state"
        click_on '更新する'
        expect(page).to have_content("2018-01-10 水 closed #{performer_name} ピアノ演奏会 ピアノの演奏会です")
      end

      it '演奏者が更新できる' do
        select new_performer_name, from: "schedule_#{schedule.id}_performer_ids"
        unselect performer_name, from: "schedule_#{schedule.id}_performer_ids"
        click_on '更新する'
        expect(page).to have_content("2018-01-10 水 open #{new_performer_name} ピアノ演奏会 ピアノの演奏会です")
      end

      it 'タイトルが更新できる' do
        fill_in "schedule_#{schedule.id}_title", with: 'バイオリン演奏会'
        click_on '更新する'
        expect(page).to have_content("2018-01-10 水 open #{performer_name} バイオリン演奏会 ピアノの演奏会です")
      end

      it '詳細が更新できる' do
        fill_in "schedule_#{schedule.id}_detail", with: 'バイオリンの演奏会です'
        click_on '更新する'
        expect(page).to have_content("2018-01-10 水 open #{performer_name} ピアノ演奏会 バイオリンの演奏会です")
      end
    end
  end
end
