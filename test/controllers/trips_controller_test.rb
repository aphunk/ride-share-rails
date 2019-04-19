require "test_helper"

describe "TripsController" do
  describe "show" do
    it "can get a valid trip" do
      passenger = Passenger.create(name: "Test Passenger", phone_num: "2065502929")
      driver = Driver.create(name: "Test Driver", vin: "01234567890123456")
      trip = Trip.create(passenger_id: passenger.id, driver_id: driver.id)
      get passenger_trip_path(passenger_id: passenger.id, id: trip.id)

      must_respond_with :success
    end

    it "will display an error for an invalid trip ID" do
      passenger = Passenger.create(name: "Test Passenger", phone_num: "2065502929")
      get passenger_trip_path(passenger_id: passenger.id, id: -1)

      must_respond_with :redirect
      expect(flash[:error]).must_equal "Could not find trip with id: -1"
    end
  end

  describe "edit" do
    it "can get the edit page for an existing trip" do
      #Arrange
      passenger = Passenger.create(name: "Test Passenger", phone_num: "2065502929")
      driver = Driver.create(name: "Test Driver", vin: "01234567890123456")
      trip = Trip.create(passenger_id: passenger.id, driver_id: driver.id)

      #Act
      get edit_passenger_trip_path(passenger_id: passenger.id, id: trip.id), params: trip

      #Assert
      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant trip" do
      passenger = Passenger.create(name: "Test Passenger", phone_num: "2065502929")
      get edit_passenger_trip_path(passenger_id: passenger.id, id: -1)

      # Assert
      must_respond_with :redirect
      expect(flash[:error]).must_equal "Could not find trip with id: -1"
    end
  end

  describe "update" do
    it "can update an existing trip" do
      passenger = Passenger.create(name: "Test Passenger", phone_num: "2065502929")
      driver = Driver.create(name: "Test Driver", vin: "01234567890123456")
      trip = Trip.create(passenger_id: passenger.id, driver_id: driver.id)

      trip_data = {
        trip: {
          rating: 5,
        },
      }

      expect {
        patch passenger_trip_path(passenger_id: passenger.id, id: trip.id), params: trip_data
      }.wont_change "Trip.count"

      must_respond_with :redirect
      must_redirect_to passenger_trips_path(trip.passenger_id)

      update_trip = Trip.find_by(id: trip.id)
      expect(update_trip.rating).must_equal trip_data[:trip][:rating]
    end

    it "will respond with bad request when attempting to edit a nonexistant trip" do
      passenger = Passenger.create(name: "Test Passenger", phone_num: "2065502929")
      patch passenger_trip_path(passenger_id: passenger.id, id: -1)

      # Assert
      must_respond_with :redirect
      expect(flash[:error]).must_equal "Could not find trip with id: -1"
    end
  end

  describe "create" do
    # it "creates a new trip" do
    #   passenger = Passenger.create(name: "Test Passenger", phone_num: "2065502929")
    #   driver = Driver.create(name: "Test Driver", vin: "01234567890123456")
    #   trip = Trip.create(passenger_id: passenger.id, driver_id: driver.id)

    #   # Act
    #   expect {
    #     post passenger_trips_path(passenger_id: passenger.id)
    #   }.must_change "Trip.count", +1

    #   # Assert
    #   must_respond_with :redirect
    #   must_redirect_to trips_path

    #   trip = Trip.last
    #   expect(trip.passenger_id).must_equal passenger.id
    #   expect(trip.driver_id).must_equal driver.id
    #   expect(trip.rating).must_be_nil
    # end
  end

  describe "destroy" do
    # Your tests go here
  end
end
