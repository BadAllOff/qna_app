class Answer < ActiveRecord::Base
  belongs_to :question, dependent: :destroy
  belongs_to :user
  has_many :attachments, as: :attachmentable
  validates :body, presence: true

  accepts_nested_attributes_for :attachments #Дабы сохранять данные в дочерний обект через родительский
end
