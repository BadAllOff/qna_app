class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @questions = Question.all
  end


  def show
    @answer = @question.answers.build
    @answer.attachments.build
  end

  def new
    @question = Question.new
    @question.attachments.build
  end

  def edit
  end

  def create
    @question = User.find(current_user.id).questions.build(question_params)
    if @question.save
      flash[:success] = 'Your question successfully created.'
      redirect_to @question
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      flash[:success] = 'Your question successfully updated.'
      redirect_to @question
    else
      render :edit
    end
  end


  def destroy
      @question.destroy
      flash[:success] = 'Your question successfully deleted.'
      redirect_to questions_path
  end

# методы НЕ являющиеся интерфейсом класса. Вызываемые только внутри
  private
# protected если полагаеться наследование
  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    # Для вложенных параметров ОБЪЯЗАТЕЛЬНО должен быть указан массив допустимых параметров
    params.require(:question).permit(:title, :body, attachments_attributes: [:file, :_destroy ])
  end
end
