require "test_helper"

describe DriversController do
  let (:driver) {
    Driver.create name: "Alfred Jenkins", vin: "2A8HR541X9R665072"
  }

  describe "index" do
    it "can get index" do
      # Act
      get drivers_path

      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid driver" do
      # Act
      get driver_path(driver.id)

      # Assert
      must_respond_with :success
    end

    it "will redirect for an invalid driver" do
      # Act
      get driver_path(-1)

      # Assert
      must_respond_with :redirect
      expect(flash[:error]).must_equal "Could not find driver with id: -1"
    end
  end

  describe "edit" do
    it "can get the edit page for an existing driver" do
      #Arrange
      driver_data = {
        name: "Updated Name",
        vin: "NEWSX9C51FT697232",
      }

      #Act
      get edit_driver_path(driver.id), params: driver_data

      #Assert
      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant driver" do
      #Act
      get edit_driver_path(-1)

      # Assert
      must_respond_with :redirect
      expect(flash[:error]).must_equal "Could not find driver with id: -1"
    end
  end

  describe "update" do
    it "can update an existing driver" do
      id = Driver.first.id

      driver_data = {
        driver: {
          name: "New name",
          vin: "NEWNUMC51FT697232",
        },
      }

      expect {
        patch driver_path(id), params: driver_data
      }.wont_change "Driver.count"

      must_respond_with :redirect
      must_redirect_to driver_path

      driver = Driver.find_by(id: id)
      expect(driver.name).must_equal driver_data[:driver][:name]
      expect(driver.vin).must_equal driver_data[:driver][:vin]
    end

    it "will redirect to the root page if given an invalid id" do
      id = -1

      driver_data = {
        name: "Update failure name",
        vin: "FAILC9C51FT697232",
      }

      patch driver_path(id), params: driver_data

      must_respond_with :redirect
      expect(flash[:error]).must_equal "Could not find driver with id: -1"
    end

    it "responds with BAD REQUEST for bad data" do
      driver = Driver.create(name: "Test Driver", vin: "1FUJA6CG57LY48020")
      # Arrange
      driver_data = {
        driver: {
          name: "New name",
          vin: "bad vin",
        },
      }

      # Assumptions
      driver.assign_attributes(driver_data[:driver])
      expect(driver).wont_be :valid?
      driver.reload

      # Act
      patch driver_path(driver), params: driver_data

      # Assert
      must_respond_with :bad_request
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
