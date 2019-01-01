module Api
  module V1
    class InstrumentsController < Api::V1::BaseController
      def index
        instruments = Instrument.select_api_attr.all
        render json: instruments
      end

      def show
        instrument = Instrument.select_api_attr.find(params[:id])
        render json: instrument
      end
    end
  end
end
