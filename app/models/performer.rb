class Performer < ApplicationRecord
  belongs_to :instrument
  delegate :name, to: :instrument, prefix: :instrument

  validates :name, presence: true
end
