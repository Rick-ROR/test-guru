class HistoryTestsController < ApplicationController

  before_action :get_history_test, only: %i[show result update gist]

  def	show
  end

  def	result
    @score = @history_test.score_test
  end

  def	update
    @history_test.accept!(params[:answer_ids])

    if @history_test.completed?
      TestsMailer.completed_test(@history_test).deliver_now

      badges = BadgeDistributionService.new(@history_test).distribution.compact


      flash_options = unless badges.empty?
                        { notice: t('.success', badges: "#{badges.collect(&:title).join(', ')}") }
                      end

      redirect_to result_history_test_path(@history_test), flash_options || {}
    else
      render :show
    end
  end

  def gist
    client = GistQuestionService.new(@history_test.current_question)
    response = client.call

    flash_options = if client.success?
                      current_user.gists.create(question_id: @history_test.current_question.id, url: response.id)

                      { notice: t('.success', url: "#{view_context.link_to("GIST", response.html_url, target: "_blank")}") }
                    else
                      { alert: t('.failure') }
                    end

    redirect_to @history_test, flash_options
  end

  private

  def get_history_test
    @history_test = HistoryTest.find(params[:id])
  end
end
