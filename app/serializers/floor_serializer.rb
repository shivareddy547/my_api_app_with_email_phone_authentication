class FloorSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :tables
end
