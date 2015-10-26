class Poster < ActiveRecord::Base
  default_scope { order('created_at DESC') }

  def feedtext
    if text.length > 100
      text[1...50] + "..."
    else
      text
    end
  end
end
