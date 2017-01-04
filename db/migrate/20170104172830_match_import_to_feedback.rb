class MatchImportToFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :self_assessment, :string
    add_column :feedbacks, :more_enjoyable, :text
    add_column :feedbacks, :more_productive, :text
    add_column :feedbacks, :help_more, :text
    add_column :feedbacks, :help_le, :text
    add_column :feedbacks, :additional_feedback, :text
  end
end
