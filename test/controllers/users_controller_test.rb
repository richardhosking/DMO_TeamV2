require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:richard)
    @other_user = users(:archer)    
  end
  
  test "should get new" do
    get signup_path
    assert_response :success
  end

    test "should redirect edit update index when not logged in" do
      get edit_user_path(@user)
      assert_not flash.empty?
      assert_redirected_to login_url
      patch user_path(@user), params: { user: @user.name,
                                        email: @user.email }
      assert_not flash.empty?
      assert_redirected_to login_url
      get users_path
      assert_redirected_to login_url      
  end

    test "should redirect update when not logged in" do
      patch user_path(@user), params: { user: @user.name,
                                        email: @user.email }
      assert_not flash.empty?
      assert_redirected_to login_url
  end
  
   test "should redirect edit when wrong user" do
     log_in_as(@other_user)
     get edit_user_path(@user)
      assert_not flash.empty?
      assert_redirected_to login_url
  end  

    test "should redirect update when wrong user" do
      log_in_as(@other_user)
      patch user_path(@user), params: { user: @user.name,
                                        email: @user.email }
      assert_not flash.empty?
      assert_redirected_to login_url
  end
  
  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: {
                                    user: { password:              @other_user.password,
                                            password_confirmation: @other_user.password,
                                            admin: false } }
    assert_not @other_user.admin?
  end
  
  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
    delete user_path(@other_user)
    assert_redirected_to login_path
    end
  end
  
   test "feed should have the right posts" do
    michael = users(:richard)
    archer  = users(:archer)
    lana    = users(:lana)
    # Posts from followed user
    lana.microposts.each do |post_following|
      assert michael.feed.include?(post_following)
    end
    # Posts from self
    michael.microposts.each do |post_self|
      assert michael.feed.include?(post_self)
    end
    # Posts from unfollowed user
    archer.microposts.each do |post_unfollowed|
      assert_not michael.feed.include?(post_unfollowed)
    end
  end
  
end
