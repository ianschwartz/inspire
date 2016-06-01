class PostersController < ApplicationController
  before_action :all_posters, only: [:new, :show]

  def new
    if params[:subreddit]
      @poster = Scrape.new(params[:subreddit])
    else
      @poster = Scrape.new('quotes')
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
    respond_to do |format|
      format.html
      format.png do
        expires_in 24.hours, public: true
        kit = IMGKit.new render_to_string
        kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/application.scss"
        send_data kit.to_png, type: "image/png", disposition: "inline"
      end
    end
  end

  private

  def poster_params
    params.require(:poster).permit(:text, :image, :link, :imageurl)
  end

  def all_posters
    @posters = Poster.paginate(:page => params[:page], :per_page => 6)
  end
end
