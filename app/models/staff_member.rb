class StaffMember < ApplicationRecord
  belongs_to :user

  # Attributes:
  #   :name (string)
  #   :role (string)
  #   :email (string)
  #   :phone (string)
  #   :status (string)
  #   :avatar (string)
  #   :user_id (integer)

end