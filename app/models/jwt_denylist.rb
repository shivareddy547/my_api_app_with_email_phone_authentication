class JwtDenylist < ApplicationRecord
  belongs_to :user

  # Attributes:
  #   :jti (string)
  #   :exp (datetime)
  #   :user_id (integer)

end