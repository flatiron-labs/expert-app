class TimeSheetAdapter

  require 'csv'

  def self.import
    files_to_import = Dir["db/csv_data/hours/*"]
    files_to_import.each do | path_to_file |
      csv_text = File.read(path_to_file)
      csv = CSV.parse(csv_text, :headers => true)
      csv.each do |row|
        row_hash = row.to_hash
        shift = find_or_create_shift_by_row(row_hash)
        expert = User.find_or_create_by_full_name(row_hash["Employee"])
        Schedule.find_or_create_by(user_id: expert.id, shift_id: shift.id)
      end
    end
  end

  def self.find_or_create_shift_by_row(row)
    start_time = parse_time_by_row(row, "Start")
    end_time = parse_time_by_row(row, "End")
    Shift.find_or_create_by(start_time: start_time, end_time: end_time)
  end

  def self.parse_time_by_row(row, key_name)
    time = Time.parse(row.to_hash["Date"] + " " + row.to_hash[key_name])
    if key_name == "End" && time.hour <= Time.parse("5:00 am").hour
      time += 1.day
    end
    time
  end

end
