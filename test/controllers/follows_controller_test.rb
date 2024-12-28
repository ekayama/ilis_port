require "test_helper"

class FollowsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get follows_create_url
    assert_response :success
  end

  test "should get destroy" do
    get follows_destroy_url
    assert_response :success
  end

  test "should get followings" do
    get follows_followings_url
    assert_response :success
  end

  test "should get followers" do
    get follows_followers_url
    assert_response :success
  end
end
