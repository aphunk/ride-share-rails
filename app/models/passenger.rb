class Passenger < ApplicationRecord
  has_many :trips

  # must provide a valid phone number
  validates :phone_num, presence: true
  validates :name, presence: true
end
