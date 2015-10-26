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
    links = @textpage.css('div.link a.title')
    @link ||= links[rand(25)]
    @link
  end

  def text
    "#{link.text}"
  end

  def url
    "https://www.reddit.com#{link['href']}"
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
