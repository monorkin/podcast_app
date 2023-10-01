require "test_helper"

class Podcast::EpisodeFetcherJobTest < ActiveJob::TestCase
  test "calls #fetch_episodes on the passed Podcast" do
    mock = Minitest::Mock.new
    mock.expect :fetch_episodes, nil
    mock.expect(:is_a?, false) { |object| !object.is_a?(Podcast) }

    Podcast::EpisodeFetcherJob.perform_now(mock)

    mock.verify
  end
end
