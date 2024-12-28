require "test_helper"

class PostsTypeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get posts_type_index_url
    assert_response :success
  end

  test "should get show" do
    get posts_type_show_url
    assert_response :success
  end

  test "should get create" do
    get posts_type_create_url
    assert_response :success
  end

  test "should get update" do
    get posts_type_update_url
    assert_response :success
  end

  test "should get destroy" do
    get posts_type_destroy_url
    assert_response :success
  end
end
