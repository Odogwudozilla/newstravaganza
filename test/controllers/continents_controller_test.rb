require 'test_helper'

class ContinentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @continent = continents(:one)
  end

  test "should get index" do
    get continents_url
    assert_response :success
  end

  test "should get new" do
    get new_continent_url
    assert_response :success
  end

  test "should create continent" do
    assert_difference('Continent.count') do
      post continents_url, params: { continent: {  } }
    end

    assert_redirected_to continent_url(Continent.last)
  end

  test "should show continent" do
    get continent_url(@continent)
    assert_response :success
  end

  test "should get edit" do
    get edit_continent_url(@continent)
    assert_response :success
  end

  test "should update continent" do
    patch continent_url(@continent), params: { continent: {  } }
    assert_redirected_to continent_url(@continent)
  end

  test "should destroy continent" do
    assert_difference('Continent.count', -1) do
      delete continent_url(@continent)
    end

    assert_redirected_to continents_url
  end
end
