class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :user_id
      t.string :busy
      t.integer :screen_share
      t.string :enjoyable
      t.string :productive
      t.datetime :logged_at

      t.timestamps null: false
    end
  end
end
