class CreateMicroposts < ActiveRecord::Migration[6.0]
  def change
    create_table :microposts do |t|
      t.string :content
      t.integer :retweet_number
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
