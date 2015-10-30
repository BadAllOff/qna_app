module Attachable
  extend ActiveSupport::Concern

  included do
    has_many :attachments, as: :attachable, dependent: :destroy
    #Дабы сохранять данные в дочерний объект через родительский
    accepts_nested_attributes_for :attachments, reject_if: lambda {|a| a[:file].blank? }, allow_destroy: true
  end
end