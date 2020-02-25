class Micropost < ApplicationRecord
  validates_length_of :content, minimum: 1, maximum: 140, allow_blank: false
  belongs_to :user
  has_many :retweetings

  attr_accessor :parent_id

  def increase_retweet_number!
    update(retweet_number: retweet_number.to_i + 1)
  end
end
