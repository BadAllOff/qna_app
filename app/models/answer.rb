class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable
  validates :body, presence: true

  accepts_nested_attributes_for :attachments #Дабы сохранять данные в дочерний обект через родительский

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
