class ArticlesController < ApplicationController

	before_action :set_article, only: [:edit,:show,:update, :destroy]
	before_action :require_user, except: [:index, :show]
	before_action :require_same_user, only: [:edit, :update, :destroy]

	def index
		@articles = Article.paginate(page: params[:page], per_page: 5)
	end

	def new
		@article = Article.new
	end

	def create
		# render plain: params[:article].inspect
		@article = Article.new(article_params)

		@article = current_user
		if @article.save
			#Flashes a message, saved for just once
			flash[:success] = "The article was successfully created"
			redirect_to article_path(@article)
		else
			render :new
		end
	end

	def show
	end

	def edit
	end

	def update
		if @article.update(article_params)
			flash[:success] = "Article was successfully updated"
			redirect_to article_path(@article)
		else
			render :edit
		end
	end

	def destroy
		@article.destroy
		flash[:warning] = "Article was sucessfully deleted/destroyed"
		redirect_to articles_path
	end

	private
		# Requires the article param object and permits the data into the object
		def article_params
			params.require(:article).permit(:title, :description)
		end

		def set_article()
			@article = Article.find(params[:id])
		end

		def require_same_user
			if current_user != @article.user
				flash[:danger] = "You can only edit or delete your own articles"
				redirect_to root_path
			end
		end
end