class TweetSerializer < ActiveModel::Serializer
  attributes :id, :username, :content, :created_at, :retweet_number
  attribute :original_tweet, if: :retweet?

  def username
    object['username']
  end

  def retweet?
    object['parent_id'] != nil
  end

  def original_tweet
    {
      id: object['parent_id'],
      username: object['parent_username'],
      user_id: object['parent_user_id'],
      content: object['parent_content']
    }
  end
end
