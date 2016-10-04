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

  def shift_load
    hrq_load = HandraiseQuestion.date_range_count(start_date, end_date)
    expert_load = Shift.expert_load(start_date, end_date)
    hrq_load.each_with_object({}) do |question_hour, export_hash|
      time = question_hour["hourly"]
      expert_load = Shift.load_by_hour(time)
      time_et = DateTime.parse(time).in_time_zone('Eastern Time (US & Canada)').strftime('%Y-%m-%d-%H:00')
      export_hash[time_et] = {experts_on: expert_load, q_count: question_hour["q_count"]}
    end
  end

end
