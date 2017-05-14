require 'test_helper'

class BookmarkControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get bookmark_create_url
    assert_response :success
  end

end
