require 'rails_helper'

describe 'Api::V1::Schedules', type: :request do
  describe 'Serializer' do
    let(:json) do
      instrument = build(:schedule, :with_performer)
      serializer = ScheduleSerializer.new(instrument)
      serialization = ActiveModelSerializers::Adapter.create(serializer)
      JSON.parse(serialization.to_json)
    end

    it 'JSONのキーが正常である' do
      expect(json.keys).to contain_exactly('date', 'state', 'title', 'detail', 'performers')
      expect(json['performers'][0].keys).to contain_exactly('id', 'name', 'introduction')
    end
  end

  describe 'api/v1/monthly_schedules/:date' do
    before do
      create(:schedule, date: '2018-12-01'.to_date)
      create(:schedule, date: '2018-12-02'.to_date)
      create(:schedule, date: '2018-12-03'.to_date)
      get '/api/v1/monthly_schedules/2018-12-01'
    end

    it 'ステータスコード200を返す' do
      expect(response.status).to eq 200
    end

    it '正しいJSONが返る' do
      json = JSON.parse(response.body)
      expect(json.size).to eq 3
    end
  end

  describe 'api/v1/instruments/:id' do
    let!(:schedule) { create(:schedule, :with_performer) }

    before do
      get "/api/v1/schedules/#{schedule.date}"
    end

    it 'ステータスコード200を返す' do
      expect(response.status).to eq 200
    end

    it '正しいJSONが返る' do
      json = JSON.parse(response.body)
      expect(json['date']).to eq schedule.date.strftime('%Y-%m-%d')
      expect(json['state']).to eq schedule.state
      expect(json['title']).to eq schedule.title
      expect(json['detail']).to eq schedule.detail
      expect(json['performers'][0]['id']).to eq schedule.performers.first.id
      expect(json['performers'][0]['name']).to eq schedule.performers.first.name
      expect(json['performers'][0]['introduction']).to eq schedule.performers.first.introduction
    end
  end
end
