module Api
  class TweetsController < ApplicationController
    before_action :set_user, only: %i[create retweet]

    def index
      @page = params[:page].to_i || 1
      @tweets = TimelineQuery.call(@page)
      render json: @tweets, each_serializer: TweetSerializer
    end

    def create
      @tweet = @user.microposts.create!(content: params[:content])

      render json: @tweet
    end

    def retweet
      @original_tweet = Micropost.find(params[:tweet_id])
      @tweet          = @user.retweet(@original_tweet, params[:content])

      render json: @tweet
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end
  end
end
