class TableSerializer < ActiveModel::Serializer
  attributes :id, :floor_id, :number, :capacity, :status, :order_id, :waiter, :time_seated, :total, :created_at, :updated_at
  belongs_to :floor
end
