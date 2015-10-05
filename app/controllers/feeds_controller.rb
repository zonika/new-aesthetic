class FeedsController < ApplicationController
  def discover
    @works = User.where(artist: true).where.not(masterpiece: nil).sample(6)
  end

  def followingfeed
    if user_signed_in?
      @feed_items = current_user.feed
    end
  end
end
