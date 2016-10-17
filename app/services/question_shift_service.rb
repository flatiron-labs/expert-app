class QuestionShiftService

  attr_reader :start_date, :end_date

  def initialize(start_date, end_date)
    @start_date = convert_date_to_utc(start_date)
    @end_date =convert_date_to_utc(end_date)
  end

  def convert_date_to_utc(date)
    (DateTime.parse(date) + 10.hours)
      .in_time_zone('Eastern Time (US & Canada)')
      .beginning_of_day.utc.to_s
  end

  def blank_export_hash
    {labels:[], experts_on:[], q_count:[]}
  end

  def shift_load
    hrq_load = HandraiseQuestion.date_range_count(start_date, end_date)
    expert_load = Shift.expert_load(start_date, end_date)
    hours_array.each_with_object(blank_export_hash) do |time, export_hash|
      # time = question_hour["hourly"]
      expert_load = Shift.load_by_hour(time)
      time_et = DateTime.parse(time).in_time_zone('Eastern Time (US & Canada)').strftime('%Y-%m-%d-%H:00')
      q_count_hash = hrq_load.find {| row | row["hourly"] == time }
      q_count = q_count_hash ? q_count_hash["q_count"] : 0
      add_to_hash(export_hash, time_et, expert_load, q_count)
    end
  end

  def add_to_hash(export_hash, time_in_et, expert_load, q_count)
    export_hash[:labels] << time_in_et
    export_hash[:experts_on] << expert_load
    export_hash[:q_count] << q_count
  end

  def hours_array
    current_time = Time.parse(start_date)
    end_time = Time.parse(end_date)
    hours_array = []
    while current_time < end_time
      hours_array << current_time.to_s(:db)
      current_time += 1.hours
    end
    hours_array
  end

end
