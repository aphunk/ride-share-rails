class Passenger < ApplicationRecord
  has_many :trips

  # must provide a valid phone number
  validates :phone_num, presence: true
  validates :name, presence: true
  
  
  def total_spent
    total_spent = 0

    trips.each do |trip|
      if trip.cost
        total_spent += trip.cost 
      end
    end

    return total_spent
  end
  
end
