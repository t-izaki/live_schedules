module Api
  module V1
    class InstrumentsController < Api::V1::BaseController
      def index
        instruments = Instrument.all
        render json: instruments
      end

      def show
        instrument = Instrument.find(params[:id])
        render json: instrument
      end
    end
  end
end
