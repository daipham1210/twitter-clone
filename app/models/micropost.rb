class Micropost < ApplicationRecord
  validates_length_of :content, minimum: 1, maximum: 140, allow_blank: false
  belongs_to :user
  has_many :retweetings

  scope :timeline, -> { Micropost.order(:retweet_number, :desc).limit(10) }

  def increase_retweet_number!
    update(retweet_number: retweet_number + 1)
  end
end
