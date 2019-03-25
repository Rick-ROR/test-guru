module QuestionsHelper
  def question_header(question)
    if question.new_record?
      "Давайте создадим новый воврос!"
    else
      "Здесь можно изменить вопрос:"
    end
  end
end
