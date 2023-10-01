require "test_helper"

class Podcast::FeedTest < ActiveSupport::TestCase
  test "#cover_art_url returns the URL of the cover art" do
    podcast = podcasts(:remote_ruby)
    stub_feed_request_for(podcast.url, with: Pathname.new(file_fixture_path).join("example_feed.xml"))

    assert_equal "http://example.com/cover_art.png", podcast.feed.cover_art_url
  end

  test "#title returns the title of the podcast" do
    podcast = podcasts(:remote_ruby)
    stub_feed_request_for(podcast.url, with: Pathname.new(file_fixture_path).join("example_feed.xml"))

    assert_equal "Example Podcast", podcast.feed.title
  end

  test "#description returns the description of the podcast" do
    podcast = podcasts(:remote_ruby)
    stub_feed_request_for(podcast.url, with: Pathname.new(file_fixture_path).join("example_feed.xml"))

    assert_equal "This is an example podcast.", podcast.feed.description
  end

  test "#episodes returns an array of episodes" do
    podcast = podcasts(:remote_ruby)
    stub_feed_request_for(podcast.url, with: Pathname.new(file_fixture_path).join("example_feed.xml"))

    assert_equal 1, podcast.feed.episodes.size

    episode = podcast.feed.episodes.first

    assert_instance_of Podcast::Episode, podcast.feed.episodes.first
    assert_equal podcast, episode.podcast
    assert_equal "https://example.com/episode1", episode.guid
    assert_equal "https://example.com/file-0.mp3", episode.audio_file_url
    assert_equal "Episode 1", episode.title
    assert_equal "This is the first episode.", episode.show_notes
    assert_equal Time.parse("Thu, 01 Apr 2021 08:00:00 EST"), episode.aired_at
  end
end
