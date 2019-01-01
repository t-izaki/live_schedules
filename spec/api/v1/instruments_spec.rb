require 'rails_helper'

describe 'Api::V1::Instruments', type: :request do
  describe 'api/v1/instruments' do
    before do
      create_list(:instrument, 3)
      get '/api/v1/instruments'
    end

    it 'ステータスコード200を返す' do
      expect(response.status).to eq 200
    end

    it '正しいJSONが返る' do
      json = JSON.parse(response.body)
      expect(json.size).to eq 3
      expect(json[0].keys).to contain_exactly('id', 'name', 'color')
    end
  end

  describe 'api/v1/instruments/:id' do
    let!(:instrument) { create(:instrument) }

    before do
      get "/api/v1/instruments/#{instrument.id}"
    end

    it 'ステータスコード200を返す' do
      expect(response.status).to eq 200
    end

    it '正しいJSONが返る' do
      json = JSON.parse(response.body)
      expect(json['id']).to eq instrument.id
      expect(json['name']).to eq instrument.name
      expect(json['color']).to eq instrument.color
      expect(json.keys).to contain_exactly('id', 'name', 'color')
    end
  end
end
