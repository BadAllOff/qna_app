FactoryGirl.define do
  factory :question do
    association(:user)
    title "Question title"
    body "Question body"
  end

  factory :invalid_question, class: "Question" do
    association(:user)
    title nil
    body nil
  end

end
