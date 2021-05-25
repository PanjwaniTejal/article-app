class ArticlesController < ApplicationController

  def create
    @article = current_user.articles.new(article_params)
    if @article.save
      render json: { success: "successfully created" }, status: :ok
    else
      render json: { error: @article.errors.messages.map { |msg, desc| msg.to_s + " " + desc[0] }.join(',') }, status: :not_found
    end
  end

  def show
    @article = current_user.articles.find(params[:id])
    render json: { article: @article }, status: :ok
  end

  private
  def article_params
    params.require(:articles).permit(:title, :description)
  end
end
