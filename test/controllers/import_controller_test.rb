require 'test_helper'

class ImportControllerTest < ActionDispatch::IntegrationTest
  test "should get json" do
    get import_json_url
    assert_response :success
  end

end
