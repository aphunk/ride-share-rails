class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all
  end

  def show
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)

    unless @passenger
      redirect_to passengers_path, :flash => { :error => "Could not find passenger with id: #{passenger_id}" }
    end
  end

  def edit
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)

    unless @passenger
      redirect_to passengers_path, :flash => { :error => "Could not find passenger with id: #{passenger_id}" }
    end
  end

  def update
    @passenger = Passenger.find_by(id: params[:id])

    unless @passenger
      redirect_to passengers_path, :flash => { :error => "Could not find passenger with id: #{@passenger.id}" }
      return
    end

    if @passenger.update(passenger_params)
      redirect_to passenger_path(@passenger)
    else
      render :edit, status: :bad_request
    end
  end

  def new
    @passenger = Passenger.new
  end

  def create
    @passenger = Passenger.new(passenger_params)

    @passenger.save

    unless @passenger
    redirect_to passenger_path(@passenger), flash[:notice] = "Passenger created!"
    else
      render :new, :flash => { :error => "Could not create passenger"  }
    end
  end
  
  def destroy
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)
    
    unless @passenger
      head :not_found
      return
    end
    
    if @passenger.destroy
      redirect_to passengers_path, flash[:notice] = "Passenger successfully deleted"
    else
      render :edit, status: :bad_request
    end
  end

  private

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
  end
end
