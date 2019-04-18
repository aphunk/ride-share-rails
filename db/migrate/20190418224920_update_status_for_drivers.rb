class UpdateStatusForDrivers < ActiveRecord::Migration[5.2]
  def change
    change_column :drivers, :status, :string

    Driver.find_each do |driver|
      driver.status = "available"
      driver.save!
    end
  end
end
