class Shift < ActiveRecord::Base

  has_many :schedules
  has_many :users, through: :schedules

  validates :start_time, :end_time, presence: true

  def self.expert_load(start_date, end_date)
    sql = <<-SQL
      SELECT  start_time, end_time,
        COUNT(user_id) AS experts_on
      FROM shifts
      RIGHT JOIN schedules
        ON shifts.id = schedules.shift_id
      WHERE start_time >= $1
        AND start_time <= $2
      GROUP BY start_time, end_time
    SQL

    connection = ActiveRecord::Base.connection.raw_connection
    results = connection.exec_params(sql, [start_date, end_date])

    results.to_a
  end

  def self.shift_by_hour(hour)
    utc_hour = DateTime.parse(hour)
    where("start_time <= '#{utc_hour}' AND end_time >= '#{(utc_hour + 1.hour)}'").first
  end

  def self.load_by_hour(hour)
    shift = shift_by_hour(hour)
    shift ? shift.users.count : 0
  end

end
