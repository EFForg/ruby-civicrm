require 'byebug'

require 'civicrm'
require 'support/civicrm'
require 'support/civicrm_responses'
require 'support/test_matchers'

RSpec.configure do |config|
  include CiviCrm::TestResponses

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
end
