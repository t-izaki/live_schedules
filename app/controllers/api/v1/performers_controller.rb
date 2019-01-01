module Api
  module V1
    class PerformersController < Api::V1::BaseController
      def index
        performers = Performer.select_api_attr.all
        performers = performers.where(instrument_id: params[:instrument_id]) if params[:instrument_id]
        render json: performers
      end

      def show
        performer = Performer.select_api_attr.find(params[:id])
        render json: performer
      end
    end
  end
end
