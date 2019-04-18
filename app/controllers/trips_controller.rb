class TripsController < ApplicationController
  def show
    trip_id = params[:id]

    @trip = Trip.find_by(id: trip_id)

    unless @trip
      redirect_to passenger_trips_path, :flash => {:error => "Could not find trip with id: #{trip_id}"}
    end
  end
  
  def new
    if params[:passenger_id]
      @passenger = Passenger.find_by(id: params[:passenger_id])
      
      if @passenger
        @trip = @passenger.trips.new
      else
        head :not_found
        return
      end
    else
      @trip = Trip.new
    end
  end
  
  def create
    @trip = Trip.new(trip_params)
    
    successful = @trip.save
    if successful
      redirect_to passenger_trips_path
    else
      render :new, status: :bad_request
    end
  end
  
  private

  def trip_params
    return params.require(:trip).permit(:driver_id, :passenger_id)
  end 
end
