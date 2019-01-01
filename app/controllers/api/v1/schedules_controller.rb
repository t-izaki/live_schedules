module Api
  module V1
    class SchedulesController < Api::V1::BaseController
      before_action :set_date

      def index
        schedules = Schedule.select_in_month(@date)
        render json: schedules
      end

      def show
        schedule = Schedule.find_by!(date: @date)
        render json: schedule
      end

      private

      def set_date
        @date = params[:date].to_date
      end
    end
  end
end
