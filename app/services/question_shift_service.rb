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
    hrq_load.each_with_object(blank_export_hash) do |question_hour, export_hash|
      time = question_hour["hourly"]
      expert_load = Shift.load_by_hour(time)
      time_et = DateTime.parse(time).in_time_zone('Eastern Time (US & Canada)').strftime('%Y-%m-%d-%H:00')
      # export_hash[time_et] = {experts_on: expert_load, q_count: question_hour["q_count"]}
      add_to_hash(export_hash, time_et, expert_load, question_hour["q_count"])
    end
  end

  def add_to_hash(export_hash, time_in_et, expert_load, q_count)
    export_hash[:labels] << time_in_et
    export_hash[:experts_on] << expert_load
    export_hash[:q_count] << q_count
  end

end
