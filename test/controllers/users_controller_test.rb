require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  fixtures :users
  setup do

    @user = users(:one)
    sign_in(@user)
    @other_user = users(:two)
  end

  test "should not get index" do
    get users_url
    assert_response :redirect
  end

  test "should not get new" do
    assert_response 422
  end

  test "should not create user" do
    assert_response 422
  end

  test "should show own user" do
    get user_url(@user.id)
    assert_response :success
  end

  test "should get edit for own user" do
    get user_url(@user.id)
    get edit_user_url(@user.id)
    assert_response :success
  end

  test "should update own user" do
    patch user_url(@user.id), params: { user: { address: @user.address, credit_card_number: @user.credit_card_number, email: @user.email, name: @user.name, password: @user.password, phone_number: @user.phone_number, username: @user.username } }
    assert_response :redirect
  end

  test "should destroy own user" do
    assert_difference("User.count", -1) do
      delete user_url(@user.id)
    end

    assert_redirected_to users_url
  end

  test "should not show other user" do
    get user_url(@other_user)
    assert_response :redirect
  end

  test "should not get edit for other user" do
    get edit_user_url(@other_user)
    assert_response :redirect
  end

  test "should not update other user" do
    patch user_url(@other_user), params: { user: { address: @other_user.address, credit_card_number: @other_user.credit_card_number, email: @other_user.email, name: @other_user.name, password: @other_user.password, phone_number: @other_user.phone_number, username: @other_user.username } }
    assert_response :redirect
  end

  test "should not destroy other user" do
    assert_difference("User.count", 0) do
      delete user_url(@other_user)
    end

    assert_redirected_to root_path
  end

  test "should show purchase history" do
    get transactions_path(@user)
    assert_response :success

    end

  test "should be able to view reviews" do
    get reviews_path(@user)
    assert_response :success
    end

  test "should be able to add to cart" do
    get new_cart_item_path(@user)
    assert_response :success
    end

  test "should add items to cart" do
    get books_path(@user)
    assert_response :success
    end

  test "should purchase a book using buy now" do
    get new_transaction_path(@user)
    assert_response :success
    end

  test "should able to add to cart" do
    get new_cart_item_path(@user)
    assert_response :success
    end


end
