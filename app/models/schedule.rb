class Schedule < ApplicationRecord
  enum state: { undecided: 0, open: 1, closed: 2 }

  validates :date, :state, presence: true
  validates :date, uniqueness: true
  validates :title, length: { maximum: 255 }
  validates :state, numericality: { only_integer: true }
end
