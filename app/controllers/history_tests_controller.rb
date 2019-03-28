class HistoryTestsController < ApplicationController

  before_action :get_history_test, only: %i[show result update]
  before_action :get_score, only: :result
  def	show
  end

  def	result
  end

  def	update
    @history_test.accept!(params[:answer_ids])

    if @history_test.completed?
      redirect_to result_history_test_path(@history_test)
    else
      render :show
    end
  end

  private

  def get_history_test
    @history_test = HistoryTest.find(params[:id])
  end

  def get_score
    @score = @history_test.score_test
  end
  
end
