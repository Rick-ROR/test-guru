class HistoryTest < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_first_question, on: :create
  # почему не работает before_save ?
  before_update :before_update_next_question, on: :update

  PASS_SCORE = 85

  def completed?
    current_question.nil?
  end

  def accept!(answer_ids)
    if correct_answer?(answer_ids)
      self.correct_questions += 1
    end
    save!
  end

  def score_test
    (self.correct_questions.to_f / self.test.questions.count * 100).round
  end

  def passed?
    true if score_test > PASS_SCORE
  end

  def show_progress
    "#{test.questions.index(current_question) + 1} / #{test.questions.count}"
  end

  private

  def before_validation_set_first_question
    self.current_question = test.questions.first if test.present?
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == answer_ids.map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end

  def before_update_next_question
    self.current_question = test.questions.order(:id).where('id > ?', current_question.id).first
  end

end

