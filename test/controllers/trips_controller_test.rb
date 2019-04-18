require "test_helper"

describe "TripsController" do
  describe "show" do
    it "can get a valid trip" do
      get passenger_trip_path(trip.id)

      must_respond_with :success
    end

    it "will display an error for an invalid trip ID" do
      get passenger_trip_path(-1)

      must_respond_with :redirect
      expect(flash[:error]).must_equal "Could not find trip with id: -1"
    end
  end

  describe "edit" do
    # Your tests go here
  end

  describe "update" do
    # Your tests go here
  end

  describe "create" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
