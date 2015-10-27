class PostersController < ApplicationController
  before_action :all_posters, only: [:index, :show]

  def index
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

  def all_posters
    @posters = Poster.paginate(:page => params[:page], :per_page => 6)
  end
end
