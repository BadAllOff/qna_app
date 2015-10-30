class Answer < ActiveRecord::Base
  include Attachable

  belongs_to :question
  belongs_to :user
  validates :body, presence: true


  default_scope { order('best_answer DESC, created_at') }

  def set_best
    transaction do
      question.answers.update_all(best_answer: false)
      update!(best_answer: true)
    end
  end

  def cancel_best
    update!(best_answer: false)
  end
end
