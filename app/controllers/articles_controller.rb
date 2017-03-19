class ArticlesController < ApplicationController
	def index
		@articles = Article.all
	end

	def new
		@article = Article.new
	end

	def create
		# render plain: params[:article].inspect

		@article = Article.new(article_params)
		if @article.save
			#Flashes a message, saved for just once
			flash[:notice] = "The article was successfully created"
			redirect_to article_path(@article)
		else
			render :new
		end
	end

	def show
		@article = Article.find(params[:id])
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])
		if @article.update(article_params)
			flash[:notice] = "Article was successfully updated"
			redirect_to article_path(@article)
		else
			render :edit
		end
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy
		flash[:notice] = "Article was sucessfully deleted/destroyed"
		redirect_to articles_path
	end

	private
		# Requires the article param object and permits the data into the object
		def article_params
			params.require(:article).permit(:title, :description)
		end
end