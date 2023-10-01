require "test_helper"

class Podcast::ImportTest < ActiveSupport::TestCase
  test ".from_url delegates to an instance of self and call import" do
    check_if_podcast_is_valid do |url:|
      Podcast::Import.from_url(url)
    end
  end

  test "#import creates a new podcast from the feed at the given URL" do
    check_if_podcast_is_valid do |url:|
      Podcast::Import.new(url: url).import
    end
  end

  def check_if_podcast_is_valid(url: "http://example.com/feed", &block)
    stub_feed_request_for(url, with: Pathname.new(file_fixture_path).join("example_feed.xml"))

    podcast = block.call(url: url)

    assert_instance_of Podcast, podcast
    assert podcast.persisted?
    assert_equal "http://example.com/feed", podcast.url
    assert_equal "Example Podcast", podcast.title
    assert_equal "This is an example podcast.", podcast.description
    assert_equal "http://example.com/cover_art.png", podcast.cover_art_url
  end
end
