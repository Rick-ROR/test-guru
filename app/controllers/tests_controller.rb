class TestsController < ApplicationController

  before_action :authenticate_user!
  before_action :get_test, only: %i[start]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_quest_404

  def index
    @tests = Test.all
  end

  def start
    current_user.tests.push(@test)
    redirect_to current_user.test_passage(@test)
  end

  private

  def rescue_with_quest_404
    render plain: '404. Этот тест мы ещё не успели придумать.', status: 404
  end

  def get_test
    @test = Test.find(params[:id])
  end
end
