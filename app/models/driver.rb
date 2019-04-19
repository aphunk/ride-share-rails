class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, presence: true, uniqueness: true, length: {is: 17}

  def total_revenue
    total_revenue = 0

    trips.each do |trip|
      if trip.cost
        total_revenue += (trip.cost - 1.65) * 0.8
      end
    end

    return total_revenue
  end

  def average_rating
    return 0 if trips.length == 0
    total = 0

    trips.each do |trip|
      if trip.rating
        total += trip.rating
      end
    end

    return total / trips.length
  end
end
