require 'test_helper'

class EventsEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @event = events(:halloween)
    @user = users(:jon)
  end
  
  test "unsuccessful edit" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: @user.email, password: 'password' }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
    get edit_event_path(@event)
    assert_template 'events/edit'
    patch event_path(@event), event: {title: "", description: "", location: "",
                                      event_date: "", event_time: "", host_id: "" }
    assert_template 'events/edit'
  end
  
  test "successful edit" do 
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: @user.email, password: 'password' }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
    patch event_path(@event), event: { title: "Ghoulish Party", description: "Do not forget your costume!", address: "The Crypt",
                                      event_date: "2015-04-22", event_time: "2015-04-22 09:40:38", host_id: "1" }
    assert_not flash.empty?
    assert_redirected_to @event
    @event.reload
    assert_equal "Ghoulish Party",  @event.title
    assert_equal "Do not forget your costume!", @event.description
    assert_equal "The Crypt", @event.address
  end
  
  
  
end
