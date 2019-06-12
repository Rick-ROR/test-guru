class HistoryTestsController < ApplicationController

  before_action :get_history_test, only: %i[show result update gist]
  before_action :set_timeout, only: %i[show result update gist]

  def	show
    # update_timeout
    #
    # byebug
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
    # byebug
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
    @timeout = Time.now - @history_test.start_time
  end

  # если self.timeout NoMethodError: private method `timeout' called for #<HistoryTestsController:0x00007f8a348c1ed0>
  # def update_timeout
  #   if @history_test.timeout == nil
  #     @history_test.update(timeout: Time.now)
  #   end
  # end
  # +++
  # def update_timeout
  #   if HistoryTest.find(params[:id]).timeout == nil
  #     HistoryTest.find(params[:id]).update(timeout: Time.now)
  #   end
  # end

  def set_timeout
    if @history_test.test.time == 0
      @timeout = nil
    else
      @timeout = (@history_test.test.time * 60 - (Time.now - @history_test.start_time)).round
    end
  end
end
