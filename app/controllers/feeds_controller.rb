class FeedsController < ApplicationController
  def discover
    w = User.where(artist: true).where.not(masterpiece: nil).sample(6)
    @works = w.collect do |user|
      Work.find(user.masterpiece)
    end
  end

  def followingfeed
    if user_signed_in?
      @feed_items = current_user.feed
    end
  end

  def random
    w = User.where(artist: true).where.not(masterpiece: nil).sample(6)
    @works = w.collect do |user|
      Work.find(user.masterpiece)
    end
    render 'feeds'
  end

  def most_collected
    @works =  Work.order(times_collected: :desc)[0...6]
    render 'feeds'
  end
end
