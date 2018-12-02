require 'rails_helper'

describe 'Instruments', type: :feature do
  before do
    admin = create(:admin)
    login_as(admin, scope: :admin)
  end

  describe '#index' do
    before { create(:instrument, name: 'piano', color: '#000') }

    it 'instrumentsが表示できる' do
      visit '/instruments'
      expect(page).to have_http_status(:success)
      expect(page).to have_content('piano').and have_content('#000')
    end
  end

  describe '#new->#create' do
    it 'instrumentが作成できる' do
      visit '/instruments/new'
      fill_in 'Name', with: 'cello'
      fill_in 'Color', with: '#aaa'
      click_on '作成する'
      expect(page).to have_http_status(:success)
      expect(page).to have_content('cello').and have_content('#aaa')
    end
  end

  describe '#edit->#update' do
    let(:instrument) { create(:instrument, name: 'piano', color: '#000') }

    it 'instrumentが更新できる' do
      visit "/instruments/#{instrument.id}/edit"
      fill_in 'Name', with: 'soprano'
      fill_in 'Color', with: '#bbb'
      click_on '更新する'
      expect(page).to have_http_status(:success)
      expect(page).to have_content('soprano').and have_content('#bbb')
    end
  end

  describe '#destroy' do
    let(:instrument) { create(:instrument, name: 'piano', color: '#000') }

    it 'instrumentが削除できる' do
      visit "/instruments/#{instrument.id}/edit"
      click_on 'この楽器を削除する'
      expect(page).to have_http_status(:success)
      expect(page).not_to have_content('piano')
    end
  end
end
