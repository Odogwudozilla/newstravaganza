require 'test_helper'

class UsersearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get usersearches_new_url
    assert_response :success
  end

  test "should get index" do
    get usersearches_index_url
    assert_response :success
  end

  test "should get edit" do
    get usersearches_edit_url
    assert_response :success
  end

  test "should get show" do
    get usersearches_show_url
    assert_response :success
  end

end
