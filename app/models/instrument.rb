class Instrument < ApplicationRecord
  has_many :performers

  validates :name, :color, presence: true
  validates :name, uniqueness: true
  validates :name, length: { maximum: 255 }
  validates :color, format: { with: /\A#([\da-fA-F]{6}|[\da-fA-F]{3})\z/ }

  scope :select_api_attr, lambda {
    select(:id, :name, :color)
  }
end
