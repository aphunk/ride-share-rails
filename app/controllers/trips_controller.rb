class TripsController < ApplicationController
  def index
    @passenger = Passenger.find_by(id: params[:passenger_id])
    @passenger.trips.all
  end

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
    driver = Driver.find_by(status: "available")

    trip_data = {
      passenger_id: params[:passenger_id],
      rating: nil,
      date: Date.today,
      cost: rand(4..120),
      driver_id: driver.id,
    }

    @passenger = Passenger.find(params[:passenger_id])
    @trip = Trip.new(trip_data)

    successful = @trip.save
    if successful
      redirect_to passenger_path(@passenger)
    else
      render :new, status: :bad_request
    end
  end

  def edit
    trip_id = params[:id]
    @passenger = Passenger.find(params[:passenger_id])

    @trip = Trip.find_by(id: trip_id)

    unless @trip
      redirect_to passenger_trips_path(@passenger.id), :flash => {:error => "Could not find trip with id: #{trip_id}"}
    end
  end

  def update
    @trip = Trip.find_by(id: params[:id])

    if @trip.update(trip_params)
      redirect_to passenger_trips_path(@trip.passenger_id)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    trip_id = params[:id]

    trip = Trip.find_by(id: trip_id)

    unless trip
      head :not_found
      return
    end

    successful = trip.destroy

    if successful
      flash[:info] = "Event deleted"

      redirect_to :back
    end
  end

  private

  def trip_params
    return params.require(:trip).permit(:driver_id, :passenger_id, :rating)
  end 

end