class ArticlesController < ApplicationController
  before_action :find_article, only: [:edit, :update, :show,:destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  # 'update' is submission of 'edit'
  
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end
  
  def edit
  end
  
  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      # flash shows on first redirect
      flash[:success] = "Article was successfully created"
      redirect_to article_path(@article)
    else      # validations fail@ed
      # render the new template
      render 'new'    
    end
  end
  
  def update
    if @article.update(article_params)
      flash[:success] = "Article successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end
  
  def show
  end
  
  def destroy
    @article.destroy
    flash[:danger] = "Article successfully deleted"
    redirect_to articles_path
  end
  
  private
  def find_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end
    
  def require_same_user
    # error if not the article creator and not an admin
    if current_user != @article.user && !current_user.admin?
      flash[:danger] = "You can only edit or delete your own article"
      redirect_to root_path
    end
  end
  
end