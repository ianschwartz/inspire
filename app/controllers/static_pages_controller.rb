class StaticPagesController < ApplicationController
  def index
    @poster = Scrape.new
  end
end
