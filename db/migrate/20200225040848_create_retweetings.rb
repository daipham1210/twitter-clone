class CreateRetweetings < ActiveRecord::Migration[6.0]
  def change
    create_table :retweetings do |t|
      t.references :user, foreign_key: true
      t.references :micropost, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
