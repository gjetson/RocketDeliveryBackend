require "application_system_test_case"

class CourierStatusesTest < ApplicationSystemTestCase
  setup do
    @courier_status = courier_statuses(:one)
  end

  test "visiting the index" do
    visit courier_statuses_url
    assert_selector "h1", text: "Courier statuses"
  end

  test "should create courier status" do
    visit courier_statuses_url
    click_on "New courier status"

    fill_in "Name", with: @courier_status.name
    click_on "Create Courier status"

    assert_text "Courier status was successfully created"
    click_on "Back"
  end

  test "should update Courier status" do
    visit courier_status_url(@courier_status)
    click_on "Edit this courier status", match: :first

    fill_in "Name", with: @courier_status.name
    click_on "Update Courier status"

    assert_text "Courier status was successfully updated"
    click_on "Back"
  end

  test "should destroy Courier status" do
    visit courier_status_url(@courier_status)
    click_on "Destroy this courier status", match: :first

    assert_text "Courier status was successfully destroyed"
  end
end
