class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :trackable,
         :confirmable

  # include Auth

  has_many :history_tests
  has_many :tests, through: :history_tests
  has_many :author_tests, foreign_key: 'author_id', class_name: 'Test'
  has_many :gists
  has_many :question, through: :gists
  has_many :user_badges
  has_many :badges, through: :user_badges
  
  validates :name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }

  def tests_by_level(level)
    tests.by_level(level)
  end

  def test_passage(test)
    history_tests.order(id: :desc).find_by(test_id: test.id)
  end

  def admin?
    self.type == 'Admin' ? true : false
  end
end
