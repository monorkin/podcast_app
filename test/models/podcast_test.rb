require "test_helper"

class PodcastTest < ActiveSupport::TestCase
  test ".import_from_url delegates to an instance of Podcast::Import" do
    url = "http://example.com/feed"
    stub_feed_request_for(url, with: Pathname.new(file_fixture_path).join("example_feed.xml"))

    podcast = podcasts(:remote_ruby)

    Podcast::Import.stub :from_url, podcast, [url: url] do
      assert_equal podcast, Podcast.import_from_url(url)
    end
  end

  test "#fetch_episodes_later enqueues a Podcast::EpisodeFetcherJob" do
    podcast = podcasts(:remote_ruby)

    assert_enqueued_with(job: Podcast::EpisodeFetcherJob, args: [podcast]) do
      podcast.fetch_episodes_later
    end
  end

  test "#fetch_episodes delegates to an instance of Podcast::EpisodeFetcher" do
    podcast = podcasts(:remote_ruby)
    stub_feed_request_for(podcast.url, with: Pathname.new(file_fixture_path).join("example_feed.xml"))

    mock = Minitest::Mock.new
    Podcast::EpisodeFetcher.stub :new, mock, [podcast: podcast] do
      mock.expect :fetch, nil

      podcast.fetch_episodes
    end
  end

  test "#feed returns an instance of Podcast::Feed" do
    podcast = podcasts(:remote_ruby)
    stub_feed_request_for(podcast.url, with: Pathname.new(file_fixture_path).join("example_feed.xml"))

    assert_instance_of Podcast::Feed, podcast.feed
    assert_equal podcast, podcast.feed.podcast
  end
end
