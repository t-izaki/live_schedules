class MonthlySchedulesController < ApplicationController
  before_action :set_date

  def show
    @schedules = Schedule.select_or_create_in_month(@date)
  end

  def edit
    @schedules = Schedule.select_or_create_in_month(@date)
  end

  def update
    ActiveRecord::Base.transaction do
      update_params.each do |id, attr|
        schedule = Schedule.find!(id)
        schedule.update!(attr)
      end
    end
    redirect_to monthly_schedule_path(@date), notice: 'スケジュールの更新に成功しました'
  end

  private

  def update_params
    params.permit(schedule: [:state, :title, :detail])[:schedule]
  end

  def set_date
    @date = params[:date].to_date
  end
end
