class MonthlySchedulesController < ApplicationController
  before_action :set_date

  def show
    @schedules = Schedule.select_or_create_in_month(@date).includes(:performers)
  end

  def edit
    @schedules = Schedule.select_or_create_in_month(@date)
  end

  def update
    ActiveRecord::Base.transaction do
      schedules_params.each do |id, attribute|
        schedule = Schedule.find(id)
        schedule.update!(attribute)
        attendances_update!(schedule)
      end
    end
    redirect_to monthly_schedule_path(@date), notice: 'スケジュールの更新に成功しました'
  end

  private

  def schedules_params
    params.permit(schedule: %i[state title detail]).require(:schedule)
  end

  def attendances_params
    params.permit(schedule: [performer_ids: []]).require(:schedule)
  end

  def attendances_update!(schedule)
    schedule.attendances.each(&:destroy!)
    performer_ids = attendances_params[schedule.id.to_s][:performer_ids].reject(&:blank?)
    performer_ids.each do |performer_id|
      schedule.attendances.create!(performer_id: performer_id)
    end
  end

  def set_date
    @date = params[:date].to_date
  end
end
