class ShiftLoadsController < ApplicationController

  def root
    redirect_to '/shift_loads'
  end

  def index

  end

  def data
    qss = QuestionShiftService.new(params['start_date'], params['end_date'])
    @shift_loads = qss.shift_load
    render :json => @shift_loads
  end

end
