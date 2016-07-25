require 'test_helper'

class EventsCreationTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:jon)
  end
  
  test "invalid event creation" do 
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: @user.email, password: 'password' }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
    get new_event_path
    assert_template 'events/new'
    assert_no_difference 'Event.count' do
    post events_path event: { title: "", description: "", location: "",
                              event_date: "", event_time: "", host_id: "" }
    end
    assert_template 'events/new'
  end
  
  test "valid event creation" do 
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: @user.email, password: 'password' }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
    get new_event_path
    assert_template 'events/new'
    assert_difference 'Event.count', 1 do
    post_via_redirect events_path, event: { title: "Cool Times", 
                                           description: "A very cool time", 
                                           address: "Cool place", 
                                           event_date: "2015-04-22", 
                                           event_time: "2015-04-22 09:40:38", 
                                           host_id: "1" }
    end
    assert_template 'events/show'
  end
  
  
end
