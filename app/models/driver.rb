class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, presence: true, uniqueness: true, length: {is: 17}

  def total_revenue
    total_revenue = 0

    trips.each do |trip|
      total_revenue += (trip.cost - 1.65) * 0.8
    end

    return total_revenue
  end

  def average_rating
    total = 0

    trips.each do |trip|
      total += trip.rating
    end

    return total / trips.length
  end
end
