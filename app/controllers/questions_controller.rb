class QuestionsController < ApplicationController
  before_action :load_question, only: [:show, :edit]

  def index
    @questions = Question.all
  end


  def show
  end

  def new
    @question = Question.new()
  end

  def edit
  end


# методы НЕ являющиеся интерфейсом класса. Вызываемые только внутри
  private
# protected если полагаеться наследование

  def load_question
    @question = Question.find(params[:id])
  end


end
