class Attendance < ApplicationRecord
  belongs_to :performer
  belongs_to :schedule

  validates :performer_id, uniqueness: { scope: :schedule_id }
end
