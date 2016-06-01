class Quote
  def initialize(subred)
    @subreddit = RedditKit.subreddit(subred)
  end

  def links
    RedditKit.links(@subreddit).results
  end

  def link
    links[rand(links.length)]
  end

  private

end
