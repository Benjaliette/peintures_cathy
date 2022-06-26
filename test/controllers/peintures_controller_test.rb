require "test_helper"

class PeinturesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get peintures_index_url
    assert_response :success
  end

  test "should get show" do
    get peintures_show_url
    assert_response :success
  end
end
