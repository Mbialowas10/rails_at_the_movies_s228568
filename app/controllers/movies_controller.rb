class MoviesController < ApplicationController
  def index
    #@movies = Movie.order("average_vote DESC")
    @movies = Movie.includes(:production_company).all.order("average_vote DESC")
  end

  def show
    @movie = Movie.find(params[:id])
  end
  def search
    wildcard_search ="% #{params[:keywords]} %"
    #debugger.log(wildcard_search)
    @movies = Movie.where("title LIKE ?", wildcard_search)
  end
end
