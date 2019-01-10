module Api
  module V1
    class SchedulesController < Api::V1::BaseController
      before_action :set_date

      def index
        schedules = Schedule.decided.select_in_month(@date).includes(performers: :instrument)
        render json: schedules, include: ['performers', 'performers.instrument']
      end

      def show
        schedule = Schedule.decided.find_by(date: @date)
        render json: schedule
      end

      private

      def set_date
        @date = params[:date].to_date
      end
    end
  end
end
