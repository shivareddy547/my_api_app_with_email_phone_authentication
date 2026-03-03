class Category < ApplicationRecord
  belongs_to :user

  # Attributes:
  #   :name (string)
  #   :description (text)
  #   :user_id (integer)

end