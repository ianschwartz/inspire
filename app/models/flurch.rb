class Scrape
  require 'open-uri'
  
  def initialize(subreddit_name)
    @subreddit_name = subreddit_name
  end

  def post
    Poster.new(text: subreddit_text, image: flickr_image)
  end

  def subreddit_link_text
    subreddit_link.css('a.title').text
  end

  def subreddit_link_url
    subreddit_link.css('a.comments').map { |link| link['href'] }.first
  end

  def subreddit_link
    @subreddit_link ||= subreddit_links[rand(25)]
  end

  def subreddit_text
    subreddit_link.text
  end

  def flickr_imagelink_url
    "https://www.flickr.com#{flickr_imagepage.at_css("td.Owner a")['href']}"
  end

  def flickr_image
    @flickr_image ||= flickr_image!
  end

  private

  def flickr_image!
    Nokogiri::HTML(open(flickr_imagelink_url)).at_css("img.main-photo")['src']
  end

  def reddit_url
    return "https://www.reddit.com/" if @subreddit_name.blank?
    "https://www.reddit.com/r/#{@subreddit_name}"
  end

  def subreddit_links
    reddit_textpage.css('div.link')
  end

  def flickr_imagepage
    @flickr_imagepage ||= Nokogiri::HTML(open('https://www.flickr.com/explore/interesting/7days'))
  end

  def reddit_textpage
    @reddit_textpage ||= Nokogiri::HTML(open(reddit_url))
  end
end
