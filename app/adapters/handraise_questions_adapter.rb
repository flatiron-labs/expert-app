class HandraiseQuestionsAdapter

  require 'csv'

  def self.import
    files_to_import = Dir["db/csv_data/hrq-dump*"]
    files_to_import.each do | path_to_file |
      csv_text = File.read(path_to_file)
      csv = CSV.parse(csv_text, :headers => true)
      csv.each do |row|
        row_hash = row.to_hash
        HandraiseQuestion.find_or_create_by(row_hash)
      end
    end
  end

end
