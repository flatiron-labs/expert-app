class QuestionShiftService

  attr_reader :start_date, :end_date

  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end

  def shift_load
    hrq_load = HandraiseQuestion.date_range_count(start_date, end_date)
    expert_load = Shift.expert_load(start_date, end_date)
    hrq_load.each_with_object({}) do |question_hour, export_hash|
      time = question_hour["hourly"]
      expert_load = Shift.load_by_hour(time)
      export_hash[time] = {experts_on: expert_load, q_count: question_hour["q_count"]}
    end
  end

end
