require 'rails_helper'

RSpec.describe 'Top', type: :feature do
  it 'TOPページが表示できる' do
    visit '/'
    expect(page).to have_http_status(:success)
  end
end
