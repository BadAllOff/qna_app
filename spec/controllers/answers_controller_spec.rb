require 'spec_helper'

describe AnswersController do

  let!(:question) {create :question}

  describe "POST #create" do

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

  describe 'PATCH #update' do
    let(:answer) { create(:answer, question: question) }
      it 'assigns the request answer to @answer' do
        patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
        expect(assigns(:answer)).to eq answer
      end

      it 'assigns the question' do
        patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
        expect(assigns(:question)).to eq question
      end

      it 'changes answer attributes' do
        patch :update, id: answer, question_id: question, answer: {body: 'New body'}, format: :js
        answer.reload # Что бы избежать кеширования данных и быть уверенными что только что взяли из БД
        expect(answer.body).to eq 'New body'
      end

      it 'render update template' do
        patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
        expect(response).to render_template :update
      end
  end
end
