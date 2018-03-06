class HomeController < ApplicationController

  # GET /articles
  # GET /articles.json
  def index
    redirect_to articles_path if logged_in?
  end
end
