require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:question) { create(:question, user: user) }

  describe "GET #index" do
    # Метод let вызываеться тогда когда инициализированна переменная (смотрите коммент ниже в коде)
    let(:questions) {create_list(:question, 2)} # same as @questions = create_list(:question, 2)
    before {get :index}

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(@questions) # Тут вызываеться метод let, и сохраняет объект. Не пересоздаёт.
    end

    it 'render index view' do
      expect(response).to render_template :index
    end
  end


  describe 'GET #show'  do
    before {get :show, id: question}

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question # eq то же что и == . В спеке == просто не работает
    end

    it'assigns new answer for question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'builds new attachment for answer' do
      expect(assigns(:answer).attachments.first).to be_a_new(Attachment)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end

  end


  describe 'GET #new' do
    context 'authenticated user' do
      sign_in_user
      before {get :new}

      it 'assigns a new Question to @question' do
        expect(assigns(:question)).to be_a_new(Question) #тут мы отправляем саму Модель. так как создаёться новый пустой объект
      end

      it 'builds new attachment for question' do
        expect(assigns(:question).attachments.first).to be_a_new(Attachment)
      end

      it 'renders new view' do
        expect(response).to render_template :new
      end
    end

    context 'Non-authenticated user' do
      before {get :new}

      it 'assigns new Question to @question' do
        expect(assigns(:question)).to_not be_a_new(Question)
      end

      it 'renders new user' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end


  describe 'GET #edit' do
    sign_in_user
    before {get :edit, id: question }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end


  describe 'POST #create' do
    sign_in_user
    context "with valid attributes" do
      it 'saves new question in the database' do
        expect{ post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
      end
      it 'redirects to show view' do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect{ post :create, question: attributes_for(:question) }.to change(Question, :count)
      end
      it 're-renders new view' do
        post :create, question: attributes_for(:invalid_question)
        expect(response).to render_template :new
      end
    end
  end


  describe 'PATCH #update' do
    sign_in_user
    context 'valid attributes' do
      it 'assigns the request question to @question' do
        patch :update, id: question, question: attributes_for(:question)
        expect(assigns(:question)).to eq question
      end

      it 'changes question attributes' do
        patch :update, id: question, question: {title: 'New title', body: 'New body'}
        question.reload # Что бы избежать кеширования данных и быть уверенными что только что взяли из БД
        expect(question.title).to eq 'New title'
        expect(question.body).to eq 'New body'
      end

      it 'redirects to the updated question' do
        patch :update, id: question, question: attributes_for(:question)
        expect(response).to redirect_to question
      end
    end # valid attributes

    context 'invalid attributes' do
      before  { patch :update, id: question, question: {title: 'New title', body: nil } }

      it 'does not change question attributes' do
        question.reload # Что бы избежать кеширования данных и быть уверенными что только что взяли из БД
        expect(question.title).to eq 'Question title'
        expect(question.body).to eq 'Question body'
      end

      it 're-render edit view' do
        expect(response).to render_template :edit
      end
    end # invalid attributes
  end # PATCH #update

# TODO Destroy test must be refactored for authenticated user
  describe 'DELETE #destroy' do
    context 'authenticated user' do
      sign_in_user
      it 'deletes question' do
        question
        #expect { delete :destroy, id: question }.to change(Question, :count).by(-1)
      end

      it 'redirect to question' do
        delete :destroy, id: question
        #expect(response).to redirect_to questions_path
      end
    end

    context 'another authenticated user' do
      sign_in_another_user
      it 'do not deletes question' do
        question
        expect { delete :destroy, id: question }.to_not change(Question, :count)
      end

      it 'redirect to root path' do
        delete :destroy, id: question
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'non-authenticated user' do
      it 'not deletes question' do
        question
        expect { delete :destroy, id: question }.to_not change(Question, :count)
      end

      it 'redirect to sign_in' do
        delete :destroy, id: question
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
  
end