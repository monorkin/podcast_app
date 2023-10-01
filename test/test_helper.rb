ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/mock"
require "webmock/minitest"
require "feed_request_helper"

# Allow system tests to make real network requests
WEBMOCK_ALLOWED_SITES = Set.new(%w[ localhost 127.0.0.1 ]).freeze
WebMock.disable_net_connect!(allow: -> (uri) { WEBMOCK_ALLOWED_SITES.include?(uri.host) })

module ActiveSupport
  class TestCase
    include ActiveJob::TestHelper
    include FeedRequestHelper

    parallelize(workers: :number_of_processors)

    fixtures :all
  end
end
