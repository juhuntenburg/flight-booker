class Airport < ApplicationRecord
  before_validation :normalize_name
  validates :name,
            presence: true,
            format: { with: /\A[A-Za-z]{3}\z/, message: "must be exactly three letters" }


  private

  def normalize_name
    self.name = name.to_s.strip.upcase
  end
end
