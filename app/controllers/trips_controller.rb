class TripsController < ApplicationController
  def show
    trip_id = params[:id]

    @trip = Trip.find_by(id: trip_id)

    unless @trip
      redirect_to passenger_trips_path, :flash => {:error => "Could not find trip with id: #{trip_id}"}
    end
  end
end
