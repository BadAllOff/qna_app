require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
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
    let(:question) {create(:question)} # same as @questions = create(:question)
    before {get :show, id: question}

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question # eq то же что и == . В спеке == просто не работает
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end

  end

  describe 'GET #new' do
    before {get :new}

    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question) #тут мы отправляем саму Модель. так как создаёться новый пустой объект
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    let(:question) {create(:question)}
    before {get :edit, id: question }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end


end