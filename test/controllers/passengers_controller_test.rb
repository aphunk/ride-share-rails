require "test_helper"

describe PassengersController do
  let (:passenger) {
    Passenger.create name: "Bebop Phung", phone_num: "206-323-3148"
  }
  describe "index" do
    it "can get to the index" do
      get passengers_path

      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid passenger" do
      get passenger_path(passenger.id)

      must_respond_with :success
    end

    it "will display an error for an invalid passenger ID" do
      get passenger_path(-1)

      must_respond_with :redirect
      expect(flash[:error]).must_equal "Could not find passenger with id: -1"
    end
  end

  describe "edit" do
    it "can get to a Passenger's edit page" do
      get edit_passenger_path(1)

      must_respond_with :found
    end
  end

  describe "update" do
    it "can update an existing Passenger" do
      passenger = Passenger.create!(name: "Bebop Phung")
      passenger_data = {
        passenger: {
          name: "Bebop Houle",
        },
      }

      patch passenger_path(passenger.id), params: passenger_data

      must_respond_with :redirect
      must_redirect_to passenger_path(passenger)

      passenger.reload
      expect(passenger.name).must_equal(passenger_data[:passenger][:name])
    end
  end

  describe "new" do
    # Your tests go here
  end

  describe "create" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
