require 'test_helper'

class CarCheckoutsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @car_checkout = car_checkouts(:one)
  end

  test "should get index" do
    get car_checkouts_url
    assert_response :success
  end

  test "should get new" do
    get new_car_checkout_url
    assert_response :success
  end

  test "should create car_checkout" do
    assert_difference('CarCheckout.count') do
      post car_checkouts_url, params: { car_checkout: { checkout_at: @car_checkout.checkout_at, checkout_by: @car_checkout.checkout_by, duration: @car_checkout.duration, license: @car_checkout.license } }
    end

    assert_redirected_to car_checkout_url(CarCheckout.last)
  end

  test "should show car_checkout" do
    get car_checkout_url(@car_checkout)
    assert_response :success
  end

  test "should get edit" do
    get edit_car_checkout_url(@car_checkout)
    assert_response :success
  end

  test "should update car_checkout" do
    patch car_checkout_url(@car_checkout), params: { car_checkout: { checkout_at: @car_checkout.checkout_at, checkout_by: @car_checkout.checkout_by, duration: @car_checkout.duration, license: @car_checkout.license } }
    assert_redirected_to car_checkout_url(@car_checkout)
  end

  test "should destroy car_checkout" do
    assert_difference('CarCheckout.count', -1) do
      delete car_checkout_url(@car_checkout)
    end

    assert_redirected_to car_checkouts_url
  end
end
