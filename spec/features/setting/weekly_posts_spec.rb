require 'rails_helper'

describe 'Instruments', type: :feature do
  before do
    admin = create(:admin)
    login_as(admin, scope: :admin)
  end

  describe '#edit->#update' do
    let(:textarea) { find('#weekly_posts_1_article') }

    it '更新できる' do
      visit '/setting/weekly_posts/edit'
      expect(textarea.value).not_to have_content('日曜日の投稿です')

      fill_in 'weekly_posts_1_article', with: '日曜日の投稿です'
      click_on '更新する'
      expect(page).to have_http_status(:success)
      expect(textarea.value).to have_content('日曜日の投稿です')
    end
  end
end
