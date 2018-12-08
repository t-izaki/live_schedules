class Instrument < ApplicationRecord
  has_many :performers

  validates :name, :color, presence: true
  validates :name, uniqueness: true
  validates :color, format: { with: /\A#([\da-fA-F]{6}|[\da-fA-F]{3})\z/ }
end
