class JwtDenylist < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Denylist

  belongs_to :user

  validates :jti, presence: true, uniqueness: true
  validates :exp, presence: true
end