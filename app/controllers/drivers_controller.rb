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

  def update
    driver_id = (params[:id])

    @driver = Driver.find_by(id: driver_id)

    unless @driver
      redirect_to drivers_path, :flash => {:error => "Could not find driver with id: #{driver_id}"}
      return
    end

    if @driver.update(driver_params)
      redirect_to driver_path(@driver)
    else
      render :edit, status: :bad_request
    end
  end

  def new
    @driver = Driver.new
  end

  private

  def driver_params
    return params.require(:driver).permit(:name, :vin)
  end
end
