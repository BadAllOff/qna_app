FactoryGirl.define do
  factory :answer do
    association(:question)
    association(:user)
    sequence(:body) { |i| "Text Answer #{i}" }
  end

  factory :invalid_answer, class: 'Answer' do
    association(:question)
    association(:user)
    body nil
  end

end
