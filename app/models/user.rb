class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  has_many  :microposts
  has_many  :retweetings

  def retweet(tweet, content: nil)
    retweetings.create!(micropost: tweet, content: content)
    tweet.increase_retweet_number!
  end
end
