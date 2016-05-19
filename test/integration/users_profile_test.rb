require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin_user = users(:jon)
    @non_admin_user = users(:harry)
  end
  
  test "logged in admins can see delete link and delete non admin user" do
    get login_path
    post login_path, session: { email: @admin_user.email, password: 'password' }
    get user_path(@non_admin_user)
    assert_template 'users/show'
    assert_select 'a[href=?]', user_path(@non_admin_user), text: 'Delete user'
    assert_difference 'User.count', -1 do 
      delete user_path(@non_admin_user)
    end
  end
  
  test "logged in non admin users cannot see delete link nor delete users" do 
    get login_path
    post login_path, session: {email: @non_admin_user.email, password: 'password' }
    get user_path(@admin_user)
    assert_template 'users/show'
    assert_select 'a', text: 'Delete user', count: 0
  end
    
    
  
  
end