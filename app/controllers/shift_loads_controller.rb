class ShiftLoadsController < ApplicationController

  def index

  end

  def data
    qss = QuestionShiftService.new(params['start_date'], params['end_date'])
    # binding.pry
    @shift_loads = qss.shift_load
    render :json => @shift_loads
  end

end
