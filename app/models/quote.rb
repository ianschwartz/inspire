class Quote
  def initialize(subred)
    subreddit = RedditKit.subreddit(subred)
    links = RedditKit.links(subreddit).results
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
