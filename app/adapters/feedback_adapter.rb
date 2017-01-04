class FeedbackAdapter

  require 'csv'

  KEY = {
    'Timestamp' => :logged_at, 
    'Name' => :name, 
    "Was the shift..." => :busy, 
    "How many screen shares did you do? (0 if none)" => :screen_share,
    "How enjoyable was the shift?" => :enjoyable,
    "How could it have been more enjoyable?" => :more_enjoyable,
    "How productive was the shift?" => :productive,
    "How could it have been more productive?" => :more_productive,
    "How good a job did you do of helping students?" => :self_assessment,
    "How could you do a better job of helping students?" => :help_more,
    "How could we help you to do a better job of helping students?" => :help_le,
    "Any other feedback?" => :additional_feedback
  }

  def self.import
    files_to_import = Dir["db/csv_data/feedback/*"]
    files_to_import.each do | path_to_file |
      csv_text = File.read(path_to_file)
      csv = CSV.parse(csv_text, 
        headers: true,
        converters: :all,
        header_converters: lambda { |column_name| KEY[column_name] } )


      last_log = csv[-1].to_hash[:logged_at]

      # unless Feedback.order(logged_at: :desc).first  < last_log
        import_csv(csv)
      # end
    end
  end

  def self.import_csv(csv)
    csv.each do |row|
      row_hash = row.to_hash
      full_name = row_hash.delete(:name)

      user = User.find_or_create_by_full_name(full_name)
      
      logged_at = parse_time("#{row_hash[:logged_at]}")
      
      unless user.feedbacks.find_by(logged_at: logged_at)
        user.feedbacks.create(row_hash)
      end
    end
  end
  
  def self.parse_time(time_string)
    time_string_w_zone = "#{time_string} Eastern Time (US & Canada)"
    parse_params = '%m/%d/%Y %H:%M:%S %Z'
    DateTime.strptime(time_string_w_zone, parse_params)
  end

end
