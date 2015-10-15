require 'spec_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) {create(:question)} # same as @questions = create(:question)


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

    it 'renders show view' do
      expect(response).to render_template :show
    end

  end


  describe 'GET #new' do
    sign_in_user
    before {get :new}

    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question) #тут мы отправляем саму Модель. так как создаёться новый пустой объект
    end

    it 'renders new view' do
      expect(response).to render_template :new
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
        expect(question.title).to eq 'MyString'
        expect(question.body).to eq 'MyText'
      end

      it 're-render edit view' do
        expect(response).to render_template :edit
      end
    end # invalid attributes
  end # PATCH #update


  describe 'DELETE #destroy' do
    sign_in_user
    before { question } # Внизу вызывается метод дестрой, он удалял объект сразу же как создавал. Поэтому надо инициализировать объект заранее в базе
    it 'deletes question' do
      expect { delete :destroy, id: question }.to change(Question, :count).by(-1)
    end

    it 'redirect to index view' do
      delete :destroy, id: question
      expect(response).to redirect_to questions_path
    end
  end
  
end