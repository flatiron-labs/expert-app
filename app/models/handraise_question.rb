class HandraiseQuestion < ActiveRecord::Base

  def self.date_range_count(start_date, end_date)
    sql = <<-SQL
      SELECT
        DATE_TRUNC('hour', asked_at) as hourly,
        COUNT(handraise_questions.id) AS q_count
      FROM handraise_questions
      WHERE asked_at >= $1
        AND asked_at <= $2
      GROUP BY hourly
      ORDER BY hourly
    SQL

    connection = ActiveRecord::Base.connection.raw_connection
    results = connection.exec_params(sql, [start_date, end_date])

    results.to_a
  end

end
