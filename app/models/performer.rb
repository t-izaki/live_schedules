class Performer < ApplicationRecord
  INTRODUCTION_TRUNCATE_LENGTH = 50

  has_many :attendances
  belongs_to :instrument
  delegate :name, to: :instrument, prefix: :instrument

  validates :name, :instrument_id, presence: true
  validates :name, length: { maximum: 255 }
  validates :icon_url, :image_url, format: /\A#{URI::regexp(%w(http https))}\z/, allow_blank: true
end
