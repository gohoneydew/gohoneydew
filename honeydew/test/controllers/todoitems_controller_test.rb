require 'test_helper'

class TodoitemsControllerTest < ActionController::TestCase
  setup do
    @todoitem = todoitems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:todoitems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create todoitem" do
    assert_difference('Todoitem.count') do
      post :create, todoitem: { body: @todoitem.body, completed: @todoitem.completed, task_id: @todoitem.task_id }
    end

    assert_redirected_to todoitem_path(assigns(:todoitem))
  end

  test "should show todoitem" do
    get :show, id: @todoitem
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @todoitem
    assert_response :success
  end

  test "should update todoitem" do
    patch :update, id: @todoitem, todoitem: { body: @todoitem.body, completed: @todoitem.completed, task_id: @todoitem.task_id }
    assert_redirected_to todoitem_path(assigns(:todoitem))
  end

  test "should destroy todoitem" do
    assert_difference('Todoitem.count', -1) do
      delete :destroy, id: @todoitem
    end

    assert_redirected_to todoitems_path
  end
end
