class PerformerSerializer < ActiveModel::Serializer
  attributes :id, :name, :introduction

  has_one :instrument
end
