class Question < ActiveRecord::Base
  has_many :answers
  has_many :attachments
  validates :title, :body, presence: true

  accepts_nested_attributes_for :attachments #Дабы сохранять данные в дочерний обект через родительский
end
