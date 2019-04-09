class GistQuestionService

  def initialize(question, client: nil)
    @question = question
    @test = @question.test
    @client = client || Octokit::Client.new(access_token: ENV['GIST_TOKEN'])
  end

  def call
    retries ||= 1
    
    @client.create_gist(gist_params)

  rescue Faraday::ConnectionFailed => e
    sleep(2 * retries)
    retry if (retries += 1) < 4
    return nil
  end


  def success?
    @client.last_response&.status == 201
  end

  private

  def gist_params
    { description: I18n.t('.gist_params', title: @test.title),
      files: {"test-guru-question-#{@question.id}.txt" => {
        content: gist_content
        }
      }
    }
  end

  def gist_content
    content = [@question.body]
    content += @question.answers.pluck(:body)
    content.join("\n")
  end

end
