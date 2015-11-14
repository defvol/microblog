require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      u = {
        name:                   "",
        email:                  "user@invalid",
        password:               "foo",
        password_confirmation:  "bar"
      }
      post users_path, user: u
    end
    assert_template 'users/new'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      u = {
        name: "Example user",
        email: "user@example.com",
        password: "password",
        password_confirmation: "password"
      }
      post_via_redirect users_path, user: u
    end
    assert_template 'users/show'
  end
end
