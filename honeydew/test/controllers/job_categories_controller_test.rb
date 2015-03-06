require 'test_helper'

class JobCategoriesControllerTest < ActionController::TestCase
  setup do
    @job_category = job_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:job_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create job_category" do
    assert_difference('JobCategory.count') do
      post :create, job_category: { jobs_id: @job_category.jobs_id, name: @job_category.name, user_generated: @job_category.user_generated }
    end

    assert_redirected_to job_category_path(assigns(:job_category))
  end

  test "should show job_category" do
    get :show, id: @job_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @job_category
    assert_response :success
  end

  test "should update job_category" do
    patch :update, id: @job_category, job_category: { jobs_id: @job_category.jobs_id, name: @job_category.name, user_generated: @job_category.user_generated }
    assert_redirected_to job_category_path(assigns(:job_category))
  end

  test "should destroy job_category" do
    assert_difference('JobCategory.count', -1) do
      delete :destroy, id: @job_category
    end

    assert_redirected_to job_categories_path
  end
end
