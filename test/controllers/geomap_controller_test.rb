require 'test_helper'

class GeomapControllerTest < ActionDispatch::IntegrationTest
  test "should get geocontinent" do
    get geomap_geocontinent_url
    assert_response :success
  end

  test "should get geocountries" do
    get geomap_geocountries_url
    assert_response :success
  end

end
