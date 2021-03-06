class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: [:create]
  before_action :load_answer, except: [:create]
  authorize_resource

  def create
    @answer = @question.answers.create(answer_params.merge(user: current_user))
  end

  def update
    @answer.update(answer_params)
  end

  def destroy
    @answer.destroy
  end

  def set_best
    @answer.set_best
    render 'answers/create'
  end

  def cancel_best
    @answer.cancel_best
    render 'answers/update'
  end

  private

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file, :_destroy])
  end

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
    @question = @answer.question
  end

end
