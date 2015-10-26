class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  validates :title, :body, presence: true

  accepts_nested_attributes_for :attachments, reject_if: lambda {|a| a[:file].blank? }, allow_destroy: true #Дабы сохранять данные в дочерний обект через родительский
end
