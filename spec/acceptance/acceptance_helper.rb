require 'rails_helper'

RSpec.configure do |config|
  Capybara.javascript_driver = :webkit

  config.include AcceptanceMacros, type: :feature

  # Настройки для удаления данных из базы данных после тестирования
  config.before(:suite) do # выполняеться этот код перед запуском всего файла со спеками
    DatabaseCleaner.clean_with(:truncation) #удаляются все данные при помощи стратегии truncation
  end

  config.before(:each) do # перед каждым тестом сохраняем данные в положении ТРАНЗАКЦИИ, когда данные реально НЕ ЗАПИСЫВАЮТЬСЯ в базу.
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js:true) do # для каждой спеки помеченной JS-TRUE, используем стратегию truncation. Которая создаёт данные в таблице для теста и очишает её по окончанию
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do # в начале каждого теста устанавливаем чистильшик базы для отслеживания изменений в базе
    DatabaseCleaner.start
  end

  config.after(:each) do # ну и после каждого теста чистильшик подчишает базу
    DatabaseCleaner.clean
  end

  config.use_transactional_fixtures = false
end