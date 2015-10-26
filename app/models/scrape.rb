class Scrape
  require 'open-uri'
  def initialize(sub)
    if sub == ""
      @sub = "https://www.reddit.com/"
    else
      @sub = "https://www.reddit.com/r/#{sub}"
    end
    @textpage = Nokogiri::HTML(open(@sub))
    @imagepage = Nokogiri::HTML(open('https://www.flickr.com/explore/interesting/7days/'))
  end

  def link
    links = @textpage.css('div.link')
    @link ||= links[rand(25)]
    @link.css('a.title')
  end

  def text
    link.text
  end

  def url
    @link.css('a.comments').map { |link| link['href'] }.first
  end

  def imagelink
    "https://www.flickr.com#{@imagepage.at_css("td.Owner a")['href']}"
  end

  def image
    page = Nokogiri::HTML(open(imagelink))
    # @image[rand(10)]['href']
    image = page.at_css("img.main-photo")['src']
    "http:#{image}"
  end

  def post
    Poster.new(text: text, image: image)
  end
end
