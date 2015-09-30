class FeedsController < ApplicationController
  def discover
    @works = User.where(artist: true).where.not(masterpiece: nil).sample(6)
  end
end
