# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_filter :set_article, only: [:show, :update, :destroy]

  def index
    # JSON.parse({:name => "Danny"})
    render json: Article.all
  end

  def show
    # JSON.parse({:name => "Danny"})
    render json: @article
  end

  def destroy
    # JSON.parse({:name => "Danny"})
    @article.destroy
    head :no_content
    # this will modify the header response so if someone is accessing the api,
    # they can read no_content
  end

  def update
  end

  def create
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
