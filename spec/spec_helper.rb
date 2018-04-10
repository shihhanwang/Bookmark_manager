ENV['ENVIRONMENT'] = 'test'
RACK_ENV = 'test'


require 'capybara'
require 'capybara/rspec'
require 'simplecov'
require 'simplecov-console'
# require_relative './features/web_helpers'

require File.join(File.dirname(__FILE__), '..', 'app.rb')

Capybara.app = Bookmark_Manager

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
  # Want a nice code coverage website? Uncomment this next line!
  # SimpleCov::Formatter::HTMLFormatter
])
SimpleCov.start

RSpec.configure do |config|

  con = PG.connect :dbname => 'bookmark_manager_test', :user => 'shihhanwang'
  con.exec "TRUNCATE TABLE bookmarks RESTART IDENTITY"

  config.expect_with :rspec do |expectations|

    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|

    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

end
