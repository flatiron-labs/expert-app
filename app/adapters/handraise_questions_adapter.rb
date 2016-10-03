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

        # unless HandraiseQuestion.find_by(id: row_hash[:id])
        #   binding.pry
        #
        # end
        # shift = find_or_create_shift_by_row(row_hash)
        # expert = User.find_or_create_by_full_name(row_hash["Employee"])
        # Schedule.find_or_create_by(user_id: expert.id, shift_id: shift.id)
      end
    end
  end

end
