class ArticlesController < ApplicationController
	http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

	def index
		@articles = Article.all
	end
	
	def show
		@article = Article.find(params[:id])
	end
	
	def new
		@article = Article.new
	end
	
	#selecting an article for editing
	def edit
		@article = Article.find(params[:id])
	end

	def create
		@article = Article.new(article_params)
		if @article.save
			# new request, open the saved article
			redirect_to @article
		else
			# use the same article instance currently being created
			#show it back to the user
			render 'new'
		end
	end
	
	#saving the changes made by edit
	def update
		@article = Article.find(params[:id])
		#update all proerties
		#you can also use @article.update(attribute_name: 'new title')
		if @article.update(article_params)
			redirect_to @article
		else
			render 'edit'
		end
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy

		redirect_to articles_path
	end

	#@any private stuff
	private
		def article_params
			params.require(:article).permit(:title, :text)
		end
end
