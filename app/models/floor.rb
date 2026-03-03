class Floor < ApplicationRecord
  belongs_to :user
  has_many :tables, class_name: 'Table'

  # Attributes:
  #   :name (string)
  #   :user_id (integer)

end