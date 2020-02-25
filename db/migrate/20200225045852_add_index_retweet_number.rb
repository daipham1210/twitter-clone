class AddIndexRetweetNumber < ActiveRecord::Migration[6.0]
  def change
    add_index :microposts, :retweet_number
  end
end
