class HandraiseQuestion < ActiveRecord::Base

  validates :learn_id, uniqueness: true

  default_scope { where(batch_id: SUPPORTED_BATCHES) }

  SUPPORTED_BATCHES = [
    # q-000
    286,
    # v-000
    306,
    # kwk-000
    416,
    # New Html
    421,
    # wdf-0 #Robinhood
    422,
    # Flatiron labs
    397,
    #Welcome to Learn 000
    436,
    #Welcome to Learn 001
    457,
    #Free js
    437,
    #Free js Kwk
    447,
    #Free Ruby
    438,
    #Free Ruby kwk
    448,
    #Javascript Cert
    439,
    #Ruby Cert
    440,
    #Cert html/css
    421,
    #Tech app js
    441,
    #Tech app Ruby
    442,
    #Bootcamp Prep
    460
  ]

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
