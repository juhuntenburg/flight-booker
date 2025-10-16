class Airport < ApplicationRecord
  before_validation :normalize_name
  validates :name,
            presence: true,
            format: { with: /\A[A-Za-z]{3}\z/, message: "must be exactly three letters" }

  has_many :departing_flights, foreign_key: "departure_airport_id", class_name: "Flight"
  has_many :arriving_flights, foreign_key: "arrival_airport_id", class_name: "Flight"

  private

  def normalize_name
    self.name = name.to_s.strip.upcase
  end
end
