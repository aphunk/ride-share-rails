class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end

  def show
    driver_id = params[:id]

    @driver = Driver.find_by(id: driver_id)

    unless @driver
      redirect_to drivers_path, :flash => {:error => "Could not find driver with id: #{driver_id}"}
    end
  end

  def edit
    driver_id = (params[:id])

    @driver = Driver.find_by(id: driver_id)

    unless @driver
      redirect_to drivers_path, :flash => {:error => "Could not find driver with id: #{driver_id}"}
    end
  end
end
