class FeedsController < ApplicationController
  def discover
    @works = User.where(artist: true).where.not(masterpiece: nil).sample(6)
  end
  def random
    render 'discover'
  end
  def most_collected
    w =  Work.order(times_collected: :desc)[0...6]
    @works = w.collect do |work|
      User.find(work.user_id)
    end
    render 'feeds'
  end
end
