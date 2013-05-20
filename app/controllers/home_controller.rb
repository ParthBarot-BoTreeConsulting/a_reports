class HomeController < ApplicationController
  def index
    user_name = params[:twitter_username]
    hash_tag = params[:twitter_hashtag]
    if user_name.present? && hash_tag.present?
      @search_results = twitter_search({from: user_name, hash_tag: hash_tag})
    # elsif user_name
    #   @timeline = twitter_time_line user_name
    end
  end

  private

  # def twitter_time_line(username)
  #   Twitter.user_timeline(username, count: 200)
  # end

  def twitter_search(data={})
    from = data[:from]
    hash_tag = data[:hash_tag]
    h = {}
    Twitter.search("from:#{from} #{hash_tag}", count: 100).results.map do |status|
      h[status.id] = {
        msg: status.text,
        retweet_count: Twitter.status(status.id)['retweet_count']
      }
    end
    h
  end

end