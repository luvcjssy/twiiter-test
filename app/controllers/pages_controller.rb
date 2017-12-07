class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :client

  def index
    @tweets = @client.user_timeline('twitter', count: 200)
  end

  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  def retweet
    begin
      client.retweet params[:tweet_id]
      flash[:notice] = "You have already retweeted this tweet
                        with id is #{params[:tweet_id]}."
    rescue Twitter::Error::Forbidden
      begin
        client.unretweet params[:tweet_id]
        client.retweet params[:tweet_id]
        flash[:notice] = "You have already retweeted this tweet
                          with id is #{params[:tweet_id]}."
      rescue Twitter::Error::Forbidden => e
        puts e.message
      end
    end

    redirect_to root_path
  end

  def follow
    if @client.friendship?(@client.user, 'twitter')
      @client.unfollow('twitter')
      flash[:notice] = 'You have already unfollowed Twitter.'
    else
      @client.follow('twitter')
      flash[:notice] = 'You have already followed Twitter.'
    end

    redirect_to root_path
  end

  private

  # rubocop:disable Metrics/LineLength
  def client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_app_id
      config.consumer_secret     = Rails.application.secrets.twitter_app_secret
      config.access_token        = Rails.application.secrets.twitter_access_token
      config.access_token_secret = Rails.application.secrets.twitter_access_token_secret
    end
  end
end
