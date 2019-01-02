require 'rails_helper'

describe 'Instruments', type: :feature do
  before do
    admin = create(:admin)
    login_as(admin, scope: :admin)
  end

  describe '#index' do
    let!(:performer) { create(:performer) }

    it 'performersが表示できる' do
      visit '/performers'
      expect(page).to have_http_status(:success)
      expect(page).to have_content(performer.name)
        .and have_content(performer.introduction.truncate(Performer::INTRODUCTION_TRUNCATE_LENGTH))
        .and have_content(performer.instrument_name)
    end
  end

  describe '#new->#create' do
    before { create(:instrument, name: 'Piano') }

    it 'performerが作成できる' do
      visit '/performers/new'
      fill_in 'Name', with: 'new_name'
      fill_in 'Introduction', with: 'new_introduction'
      fill_in 'Image url', with: 'http://new-image-url.example'
      fill_in 'Icon url', with: 'http://new-icon-url.example'
      select 'Piano', from: 'Instrument'
      click_on '作成する'
      expect(page).to have_http_status(:success)
      expect(page).to have_content('new_name')
        .and have_content('new_introduction')
        .and have_content('http://new-image-url.example')
        .and have_content('http://new-icon-url.example')
        .and have_content('Piano')
    end
  end

  describe '#edit->#update' do
    before { create(:instrument, name: 'Violin') }

    let(:performer) { create(:performer) }

    it 'performerが更新できる' do
      visit "/performers/#{performer.id}/edit"
      fill_in 'Name', with: 'updated_name'
      fill_in 'Introduction', with: 'updated_introduction'
      fill_in 'Image url', with: 'http://updated-image-url.example'
      fill_in 'Icon url', with: 'http://updated-icon-url.example'
      select 'Violin', from: 'Instrument'
      click_on '更新する'
      expect(page).to have_http_status(:success)
      expect(page).to have_content('updated_name')
        .and have_content('updated_name')
        .and have_content('http://updated-image-url.example')
        .and have_content('http://updated-icon-url.example')
        .and have_content('Violin')
    end
  end

  describe '#destroy' do
    let(:performer) { create(:performer, name: 'dummy_name') }

    it 'performerが削除できる' do
      visit "/performers/#{performer.id}/edit"
      click_on 'この演奏者を削除する'
      expect(page).to have_http_status(:success)
      expect(page).not_to have_content('dummy_name')
    end
  end
end
