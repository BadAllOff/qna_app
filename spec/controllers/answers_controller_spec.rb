require 'rails_helper'

describe AnswersController do

  let!(:user) { create(:user, role_sid: 'user') }
  let!(:another_user) { create(:user) }
  let (:question) { create(:question, user: user) }
  let (:answer) { create(:answer, question: question, user: user) }

  describe "POST #create" do
    context 'authenticated user' do
      before {sign_in(user)}
      context "with valid attributes" do
        it 'saves new answer in the database' do
          #Изменилось кол-во ответов для КОНКРЕТНОГО вопроса
          expect{ post :create, answer: attributes_for(:answer), question_id: question, format: :js }.to change(question.answers, :count).by(1)
        end
        it 'render create template' do
          post :create, answer: attributes_for(:answer), question_id: question, format: :js
          #it { should render_template(:partial => '_partialname') }
          expect(response).to render_template('create')
        end
      end

      context 'with invalid attributes' do
        it 'does not save the answer' do
          expect{ post :create, answer: attributes_for(:invalid_answer), question_id: question, format: :js }.to_not change(Answer, :count)
        end
        it 'redirects to questions show view' do
          post :create, answer: attributes_for(:invalid_answer), question_id: question, format: :js
          expect(response).to  render_template('create')
        end
      end
    end
  end

  describe 'PATCH #update' do
    before {sign_in(user)}
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

  describe 'PATCH #best_answer' do
    before {sign_in(user)}
    let(:answer_2) { create(:answer, question: question, user: another_user) }
    context 'author question select best answer' do
      before { patch :set_best, question_id: question, id: answer, format: :js  }

      it 'this answer the best' do
        expect(answer.reload.best_answer).to be_truthy
      end

      it 'another answer not best' do
        expect(answer_2.reload.best_answer).to be_falsey
      end

      it 'this answer became the first' do
        expect(question.answers.first).to eq answer
      end

      it 'render set_best' do
        expect(response).to render_template 'answers/create'
      end
    end

    context 'author selects the two best answers' do
      before do
        patch :set_best, question_id: question, id: answer, format: :js
        patch :set_best, question_id: question, id: answer_2, format: :js
      end

      it 'second selected answer the best' do
        expect(answer_2.reload.best_answer).to be_truthy
      end

      it 'first selected answer is not best' do
        expect(answer.reload.best_answer).to be_falsey
      end

      it 'second selected answer became the first' do
        expect(question.answers.first).to eq answer_2
      end

      it 'best answer only one' do
        expect(question.answers.where(best_answer: true).count).to eq 1
      end

      it 'render set_best' do
        expect(response).to render_template 'answers/create'
      end
    end

    context 'not author the question try to select the best answer' do
      before {sign_in(another_user)}
      before { patch :set_best, question_id: question, id: answer_2, format: :js }

      it 'selected answer is not best' do
        expect(answer_2.reload.best_answer).to be_falsey
      end

      it 'not have best answer' do
        expect(question.answers.where(best_answer: true).count).to eq 0
      end
      # TODO response status
      it 'respond status unprocessable entity' do
        #expect(response.status).to eq(422)
      end
    end

    context 'author question cancel best answer' do
      let(:answer_best) { create(:answer, question: question, user: another_user, best_answer: true) }
      before { patch :cancel_best, question_id: question, id: answer_best, format: :js }

      it 'not have best answer' do
        expect(answer_best.reload.best_answer).to be_falsey
      end

      it 'render cancel_best' do
        expect(response).to render_template 'answers/update'
      end
    end
  end


  describe 'DELETE #destroy' do
    context 'authenticated user' do
      before{sign_in(user)}
      it 'deletes answer' do
        answer
        expect { delete :destroy, id: answer, question_id: question, format: :js }.to change(Answer, :count).by(-1)
      end

      it 'render destroy template' do
        delete :destroy, id: answer, question_id: question, format: :js
        expect(response).to render_template :destroy
      end
    end

    context 'non-authenticated user' do
      it 'not deletes answer' do
        answer
        expect { delete :destroy, id: answer, question_id: question, format: :js }.to_not change(Answer, :count)
      end

      it 'redirect to sign_in' do
        delete :destroy, id: answer, question_id: question
        expect(response).to redirect_to new_user_session_path
      end
    end

  end
end
