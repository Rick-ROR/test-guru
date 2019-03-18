class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validate :validate_count_answers

  scope :correct, -> { where(correct: true) }

  private

  def validate_count_answers
    errors.add(:count_answers, "the number of responses should be <= 4") if question.answers.count > 4
  end
end
