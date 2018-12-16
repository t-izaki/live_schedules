class Schedule < ApplicationRecord
  enum state: { undecided: 0, open: 1, closed: 2 }

  validates :date, :state, presence: true
  validates :date, uniqueness: true
  validates :title, length: { maximum: 255 }
  validates :state, inclusion: { in: Schedule.states.keys }

  scope :select_in_month, lambda { |date|
    range = date.days_in_month
    where(date: range).order(:date)
  }

  def self.select_or_create_in_month(date)
    range = date.days_in_month

    ActiveRecord::Base.transaction do
      range.each { |d| find_or_create_by!(date: d) }
    end
    select_in_month(date)
  end
end
