class QuestionsController < ApplicationController
  before_action :get_test, only: %i[index create]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_quest_404

  def index
    render json: { questions: @test.questions }
  end

  def show
    render json: { questions: Question.find(params[:id])}
  end

  def new

  end

  def create
    question =  @test.questions.create(question_params)

    if question.save
      redirect_to question_path(question.id)
    else
      render plain: "Что-то пошло не так!"
    end
  end

  def destroy
    Question.destroy(params[:id])
    redirect_to test_path(@question.test_id)
  end

  private

  def get_test
    @test = Test.find(params[:test_id])
  end

  def rescue_with_quest_404
    render plain: '404. Этот вопрос мы ещё не успели добавить.'
  end

  def question_params
    params.require(:question).permit(:body)
  end
end
