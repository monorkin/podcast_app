require "test_helper"

class Podcast::EpisodeFetcherTest < ActiveSupport::TestCase
  test "#fetch creates new episodes and updates old ones from the feed" do
    podcast = podcasts(:remote_ruby)
    stub_feed_request_for(podcast.url, with: Pathname.new(file_fixture_path).join("modified_remote_ruby_feed.xml"))

    assert_difference "podcast.episodes.count", 1 do
      assert_changes -> { podcast.episodes.find_by(guid: 'e60270dd-b452-4c78-9272-16a768489b4b').title } do
        Podcast::EpisodeFetcher.new(podcast: podcast).fetch
      end
    end
  end

  test "#fetch does not create duplicate episodes or deletes ones that don't exist anymore" do
    podcast = podcasts(:remote_ruby)
    stub_feed_request_for(podcast.url, with: Pathname.new(file_fixture_path).join("modified_remote_ruby_feed.xml"))

    Podcast::EpisodeFetcher.new(podcast: podcast).fetch

    assert_no_difference "podcast.episodes.count" do
      Podcast::EpisodeFetcher.new(podcast: podcast).fetch
    end
  end

  test "#new_episodes returns an array of new episodes" do
    podcast = podcasts(:remote_ruby)
    stub_feed_request_for(podcast.url, with: Pathname.new(file_fixture_path).join("modified_remote_ruby_feed.xml"))

    assert_equal 1, Podcast::EpisodeFetcher.new(podcast: podcast).new_episodes.size
  end

  test "#changed_episodes returns an array of changed episodes" do
    podcast = podcasts(:remote_ruby)
    stub_feed_request_for(podcast.url, with: Pathname.new(file_fixture_path).join("modified_remote_ruby_feed.xml"))

    assert_equal 1, Podcast::EpisodeFetcher.new(podcast: podcast).changed_episodes.size
  end
end
