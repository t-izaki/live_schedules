class PerformerSerializer < ActiveModel::Serializer
  attributes :id, :name, :introduction, :image_url, :icon_url

  has_one :instrument
end
