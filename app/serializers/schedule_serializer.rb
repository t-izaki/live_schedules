class ScheduleSerializer < ActiveModel::Serializer
  attributes :date, :state, :title, :detail

  has_many :performers

  def date
    object.date.iso8601
  end
end
