class Instrument < ApplicationRecord
  validates :name, :color, presence: true
  validates :name, uniqueness: true
end
