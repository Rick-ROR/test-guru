class HistoryTestsController < ApplicationController

  before_action :get_history_test, only: %i[show result update]

  def	show
  end

  def	result
    @score = @history_test.score_test
  end

  def	update
    @history_test.accept!(params[:answer_ids])

    if @history_test.completed?
      TestsMailer.completed_test(@history_test).deliver_now
      redirect_to result_history_test_path(@history_test)
    else
      render :show
    end
  end

  private

  def get_history_test
    @history_test = HistoryTest.find(params[:id])
  end
end
