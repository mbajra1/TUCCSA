require 'test_helper'

class CsApplicationsControllerTest < ActionController::TestCase
  setup do
    @cs_application = cs_applications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cs_applications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cs_application" do
    assert_difference('CsApplication.count') do
      post :create, cs_application: { email: @cs_application.email, first: @cs_application.first, last: @cs_application.last, middle: @cs_application.middle, tuid: @cs_application.tuid, user_id: @cs_application.user_id }
    end

    assert_redirected_to cs_application_path(assigns(:cs_application))
  end

  test "should show cs_application" do
    get :show, id: @cs_application
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cs_application
    assert_response :success
  end

  test "should update cs_application" do
    put :update, id: @cs_application, cs_application: { email: @cs_application.email, first: @cs_application.first, last: @cs_application.last, middle: @cs_application.middle, tuid: @cs_application.tuid, user_id: @cs_application.user_id }
    assert_redirected_to cs_application_path(assigns(:cs_application))
  end

  test "should destroy cs_application" do
    assert_difference('CsApplication.count', -1) do
      delete :destroy, id: @cs_application
    end

    assert_redirected_to cs_applications_path
  end
end
