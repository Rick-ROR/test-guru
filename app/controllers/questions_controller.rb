class QuestionsController < ApplicationController
  before_action :get_test, only: %i[index new create]
  before_action :get_question, only: %i[show edit destroy update]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_quest_404

  def index
    @questions = @test.questions
  end

  def show
  end

  def new
    @question =  Question.new
  end

  def create
    @question =  @test.questions.new(question_params)

    if @question.save
      redirect_to @question
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def delete

  end

  def destroy
    question = @question.destroy
    redirect_to test_questions_path(question.test)
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
