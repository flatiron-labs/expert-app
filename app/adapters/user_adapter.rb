require 'csv'

class UserAdapter

  def self.import
    csv_text = File.read('db/csv_data/learn-experts.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      User.find_or_create_by(row.to_hash)
    end
  end

end
