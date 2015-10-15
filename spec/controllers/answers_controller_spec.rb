require 'spec_helper'

describe AnswersController do
  describe "POST #create" do

    let(:question) {create :question}

    context "with valid attributes" do
      it 'saves new answer in the database' do
        #Изменилось кол-во ответов для КОНКРЕТНОГО вопроса
        expect{ post :create, answer: attributes_for(:answer), question_id: question, format: :js }.to change(question.answers, :count).by(1)
      end
      it 'render create template' do
        post :create, answer: attributes_for(:answer), question_id: question, format: :js
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect{ post :create, answer: attributes_for(:invalid_answer), question_id: question, format: :js }.to_not change(Answer, :count)
      end
      it 'redirects to questions show view' do
        post :create, answer: attributes_for(:invalid_answer), question_id: question, format: :js
        expect(response).to  render_template :create
      end
    end
  end
end
