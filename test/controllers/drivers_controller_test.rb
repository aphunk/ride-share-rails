require "test_helper"

describe DriversController do
  let (:driver) {
    Driver.create name: "Alfred Jenkins", vin: "12345678901234567"
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
        vin: "NEW Vin Num",
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
    # Your tests go here
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
