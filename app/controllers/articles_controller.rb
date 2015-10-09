class ArticlesController < ApplicationController
 before_action :authenticate_user!, except: [:show,:index]
 before_action :set_article, except: [:index,:new,:create]
 #GET /articles
 def index
 	#Todo de base de datos  SELECT * FROM Article
 	@articles=Article.all
 end
 #GET /articles/:id
 def show
 	#Condicion  SELECT * FROM Article WHERE id='?'
 	@article.update_visits_count
 	@comment = Comment.new
 end
 #GET /articles/:id/edit
 def edit
 	#@article=Article.find(params[:id]);
 end
 #GET /articles/new
 def new
 	@article=Article.new
 	@article.categories = Category.all
 end
 #POST /articles
 def create
 	#Insert Into
 	#@article = Article.new(title: params[:article][:title], body:params[:article][:body])
 	@article = current_user.articles.new(article_params)
 	@article.categories = params[:categories]
 	if @article.save
     redirect_to @article
    else
     render:new;
    end 
 end
 #DELETE /articles/:id
 def destroy
 	#Eliminar   DELETE FROM Article WHERE id='?'
 	#@article= Article.find(params[:id])
 	@article.destroy		#Elimina el objeto de la base de datos
 	redirect_to articles_path
 end
 #PUT /articles/:id
 def update
 	#Actualizar   UPDATE Articles SET tittle='Nuevo Titulo' WHERE id='?'
 	#@article.update_attributes({title: 'Nuevo Titulo'})
 	#@article=Article.find(params[:id])
 	if @article.update(article_params)
 		redirect_to @article
 	else
 		render:edit
 	end
 end
 #Metodos privados
 private
 def set_article
 	@article= Article.find(params[:id])
 end

 def article_params
 	params.require(:article).permit(:title,:body,:cover,:categories)
 end

end