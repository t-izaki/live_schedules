require 'rails_helper'

describe 'Api::V1::Performers', type: :request do
  describe 'Serializer' do
    let(:json) do
      instrument = build(:performer)
      serializer = PerformerSerializer.new(instrument)
      serialization = ActiveModelSerializers::Adapter.create(serializer)
      JSON.parse(serialization.to_json)
    end

    it 'JSONのキーが正常である' do
      expect(json.keys).to contain_exactly('id', 'name', 'introduction', 'instrument', 'image_url', 'icon_url')
      expect(json['instrument'].keys).to contain_exactly('id', 'name', 'color')
    end
  end

  describe 'api/v1/performers' do
    describe 'allパラメータ' do
      before do
        create_list(:regular_performer, 2)
        create(:performer, regular: false)
        get "/api/v1/performers/#{params}"
      end

      context '含まれる場合' do
        let(:params) { '?all=1' }

        it 'ステータスコード200を返す' do
          expect(response.status).to eq 200
        end

        it '正しいJSONが返る' do
          json = JSON.parse(response.body)
          expect(json.size).to eq 3
        end
      end

      context '含まれない場合' do
        let(:params) { '' }

        it 'ステータスコード200を返す' do
          expect(response.status).to eq 200
        end

        it '正しいJSONが返る' do
          json = JSON.parse(response.body)
          expect(json.size).to eq 2
        end
      end
    end

    describe 'instrument_idパラメータ' do
      let!(:instrument) { create(:regular_performer).instrument }

      before do
        create_list(:regular_performer, 2)
        get "/api/v1/performers/#{params}"
      end

      context '含まれる場合' do
        let(:params) { "?instrument_id=#{instrument.id}" }

        it 'ステータスコード200を返す' do
          expect(response.status).to eq 200
        end

        it '正しいJSONが返る' do
          json = JSON.parse(response.body)
          expect(json.size).to eq 1
        end
      end

      context '含まれない場合' do
        let(:params) { '' }

        it 'ステータスコード200を返す' do
          expect(response.status).to eq 200
        end

        it '正しいJSONが返る' do
          json = JSON.parse(response.body)
          expect(json.size).to eq 3
        end
      end
    end
  end

  describe 'api/v1/performers/:id' do
    let!(:performer) { create(:performer) }

    before do
      get "/api/v1/performers/#{performer.id}"
    end

    it 'ステータスコード200を返す' do
      expect(response.status).to eq 200
    end

    it '正しいJSONが返る' do
      json = JSON.parse(response.body)
      expect(json['id']).to eq performer.id
      expect(json['name']).to eq performer.name
      expect(json['introduction']).to eq performer.introduction
    end
  end
end
