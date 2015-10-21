class PostersController < ApplicationController
  def index
    @poster = Scrape.new
    @posters = Poster.all[0..5]
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
    params.require(:poster).permit(:text, :image)
  end
end
