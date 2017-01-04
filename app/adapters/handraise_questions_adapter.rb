class HandraiseQuestionsAdapter

  require 'csv'

  def self.import
    files_to_import = Dir["db/csv_data/hrq-dump*"]
    files_to_import.each do | path_to_file |
      csv_text = File.read(path_to_file)
      csv = CSV.parse(csv_text, :headers => true)

      last_question_id = csv[-1].to_hash["learn_id"]

      # unless HandraiseQuestion.find_by(learn_id: last_question_id)
        import_csv(csv)
      # end
    end
  end

  def self.import_csv(csv)
    csv.each do |row|
      row_hash = row.to_hash
      unless HandraiseQuestion.find_by(learn_id: row_hash["learn_id"])
        HandraiseQuestion.create(row_hash)
      end
    end
  end

end
