class Table < ApplicationRecord
  belongs_to :floor

  belongs_to :user

  before_validation :assign_number, on: :create

  validates :number, presence: true, uniqueness: { scope: :floor_id }

  private

  def assign_number
    return if number.present?

    last_number = floor.tables
                       .where.not(number: nil)
                       .order(Arel.sql("CAST(SUBSTRING(number, 2) AS INTEGER) DESC"))
                       .limit(1)
                       .pluck(:number)
                       .first

    next_sequence =
      if last_number.present?
        last_number.gsub("T", "").to_i + 1
      else
        1
      end

    self.number = "T#{next_sequence}"
    self.status="available"
  end
end