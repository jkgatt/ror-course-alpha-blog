require 'test_helper'

class SigningUpTest < ActionDispatch::IntegrationTest
	
	test "signing up a new user" do
		get signup_path
		assert_template 'users/new'
		assert_difference 'User.count', 1 do
			post users_path, params: { user: {username: "test_user", email: "lol@lol.com", password: "testuser"}}
			assert_response :redirect
			follow_redirect!
		end
		assert_template 'users/show'
		assert_match "Welcome to the alpha blog", response.body
	end

end