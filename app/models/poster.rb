class Poster < ActiveRecord::Base
  default_scope { order('created_at DESC') }

  def feedtext
    if text.length > 100
      text[0...100] + "..."
    else
      text
    end
  end

  def image_url
    "https:" + image
  end
end
