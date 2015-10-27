FactoryGirl.define do
  factory :attachment do
    association(:attachable)
    file Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/test_attachments/practice_makes_perfect.jpg')))
  end

end
