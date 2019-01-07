class InstrumentSerializer < ActiveModel::Serializer
  attributes :id, :name, :color

  has_many :performers, key: :regular_performers do
    object.performers.regulars
  end
end
