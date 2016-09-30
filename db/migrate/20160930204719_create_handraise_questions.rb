class CreateHandraiseQuestions < ActiveRecord::Migration
  def change
    create_table :handraise_questions do |t|
      t.integer :learn_id
      t.datetime :asked_at
      t.datetime :resolved_at
      t.integer :asked_by_learn_id
      t.string :asked_by_github_username
      t.string :asked_by_email
      t.text :content
      t.integer :track_id
      t.integer :batch_id
      t.integer :lesson_id

      t.timestamps null: false
    end
  end
end
