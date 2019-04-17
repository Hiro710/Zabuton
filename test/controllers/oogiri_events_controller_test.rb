require 'test_helper'

class OogiriEventsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get oogiri_events_index_url
    assert_response :success
  end

  test "should get show" do
    get oogiri_events_show_url
    assert_response :success
  end

  test "should get new" do
    get oogiri_events_new_url
    assert_response :success
  end

  test "should get edit" do
    get oogiri_events_edit_url
    assert_response :success
  end

end
