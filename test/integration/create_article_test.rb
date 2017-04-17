require 'test_helper'

class CreateArticleTest < ActionDispatch::IntegrationTest
	
	def setup
		@user = User.create(username: "John1234", email: "john123@example.com", password: "password", admin: true)
	end
	
	test "creating a new article" do
		sign_in_as(@user, "password")
		get new_article_path
		assert_template 'articles/new'
		assert_difference 'Article.count', 1 do
			post articles_path, params: { article: {title: "This is a test article", description: "This is the description of the test article"}}
			assert_response :redirect
			follow_redirect!
		end
		assert_template 'articles/show'
		assert_match "The article was successfully created", response.body
	end

end