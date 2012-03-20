class TwitterController < ApplicationController
  layout "twitter"

  def index
    @media_tweet = Twitter.media_timeline('grilix', :include_entities => true).first
    get_hash_tweet
  end

  def get_hash_tweet
    @hash_tweet = Twitter.search("#ruby", :rpp=>1).first
    render :text =>@hash_tweet.text if request.xhr?
  end

end
