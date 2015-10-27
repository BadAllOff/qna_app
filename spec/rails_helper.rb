ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'spec_helper'
require 'shoulda/matchers'
require "cancan/matchers"

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

Capybara::Webkit.configure do |config|
  config.block_unknown_urls
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  # Хелпер Devise для тестирования аутентифицированных пользователей
  config.include Devise::TestHelpers, type: :controller
  # подключение макроса
  config.extend ControllerMacros, type: :controller
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.render_views = true
  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.order = :random
end
