require 'test_helper'

class PreinscriptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @preinscription = preinscriptions(:one)
  end

  test "should get index" do
    get preinscriptions_url
    assert_response :success
  end

  test "should get new" do
    get new_preinscription_url
    assert_response :success
  end

  test "should create preinscription" do
    assert_difference('Preinscription.count') do
      post preinscriptions_url, params: { preinscription: { area_id: @preinscription.area_id, lenguage_id: @preinscription.lenguage_id, studient_id: @preinscription.studient_id } }
    end

    assert_redirected_to preinscription_url(Preinscription.last)
  end

  test "should show preinscription" do
    get preinscription_url(@preinscription)
    assert_response :success
  end

  test "should get edit" do
    get edit_preinscription_url(@preinscription)
    assert_response :success
  end

  test "should update preinscription" do
    patch preinscription_url(@preinscription), params: { preinscription: { area_id: @preinscription.area_id, lenguage_id: @preinscription.lenguage_id, studient_id: @preinscription.studient_id } }
    assert_redirected_to preinscription_url(@preinscription)
  end

  test "should destroy preinscription" do
    assert_difference('Preinscription.count', -1) do
      delete preinscription_url(@preinscription)
    end

    assert_redirected_to preinscriptions_url
  end
end
