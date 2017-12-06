class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :client

  def index
    @tweets = @client.user_timeline('twitter', count: 200)
  end

  private

  def client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_app_id
      config.consumer_secret     = Rails.application.secrets.twitter_app_secret
      config.access_token        = Rails.application.secrets.twitter_access_token
      config.access_token_secret = Rails.application.secrets.twitter_access_token_secret
    end
  end
end
