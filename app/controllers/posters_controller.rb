class PostersController < ApplicationController
  def index
    @posters = Poster.all[0..5]
    if params[:subreddit]
      @poster = Scrape.new(params[:subreddit])
    else
      @poster = Scrape.new('quotes/new')
    end
  end

  def create
    @poster = Poster.new(poster_params)
    if @poster.save
      redirect_to @poster
    else
      redirect_to :back
    end
  end

  def show
    @poster = Poster.find(params[:id])
  end

  private

  def poster_params
    params.require(:poster).permit(:text, :image, :link, :imageurl)
  end
end
