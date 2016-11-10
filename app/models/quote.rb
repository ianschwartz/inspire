class Quote
  def initialize(subred)
    sub = RedditKit.subreddit(subred)
    links = RedditKit.links(sub).results
    @link = links[rand(links.length)]
  end

  def title 
    @link.title
  end

  def url
    @link.permalink
  end

  private

end
