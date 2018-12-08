class Performer < ApplicationRecord
  INTRODUCTION_TRUNCATE_LENGTH = 50

  belongs_to :instrument
  delegate :name, to: :instrument, prefix: :instrument

  validates :name, :instrument_id, presence: true
  validates :name, length: { maximum: 255 }
  validates :instrument_id, numericality: { only_integer: true }
end
