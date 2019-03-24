class QuestionsController < ApplicationController
  before_action :get_test, only: %i[index create]
  before_action :get_question, only: %i[show destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_quest_404

  def index
    render json: { questions: @test.questions }
  end

  def show
    render json: { questions: @question}
  end

  def new

  end

  def create
    question =  @test.questions.new(question_params)

    if question.save
      redirect_to question_path(question.id)
    else
      render plain: "Что-то пошло не так!"
    end
  end

  def destroy
    question = @question.destroy
    redirect_to test_path(question.test_id)
  end

  private

  def get_question
    @question = Question.find(params[:id])
  end

  def get_test
    @test = Test.find(params[:test_id])
  end

  def rescue_with_quest_404
    render plain: '404. Этот вопрос мы ещё не успели добавить.', status: 404
  end

  def question_params
    params.require(:question).permit(:body)
  end
end
