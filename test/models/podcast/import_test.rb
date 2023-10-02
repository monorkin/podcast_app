require "test_helper"

class Podcast::ImportTest < ActiveSupport::TestCase
  test ".from_url delegates to an instance of self and call import" do
    check_if_podcast_is_valid do |url:|
      Podcast::Import.from_url(url)
    end
  end

  test ".from_itunes delegates to an instance of self and call import" do
    podcast = check_if_podcast_is_valid do |url:|
      Podcast::Import.from_itunes(url: url, collection_id: "123456")
    end

    assert_equal 1, podcast.external_ids.count
    assert_equal "123456", podcast.external_ids.from_itunes.first.identifier
  end

  test "#import creates a new podcast from the feed at the given URL" do
    check_if_podcast_is_valid do |url:|
      Podcast::Import.new(url: url).import
    end
  end

  test "#import adds an external ID to a podcast if it doesn't already have it" do
    podcast = podcasts(:remote_ruby)
    stub_feed_request_for(podcast.url, with: Pathname.new(file_fixture_path).join("modified_remote_ruby_feed.xml"))
    new_external_id = "123456"
    expected_external_ids = [new_external_id, *podcast.external_ids.from_itunes.pluck(:identifier)].map(&:to_s)

    assert_difference -> { podcast.external_ids.count }, 1 do
      Podcast::Import.new(
        url: podcast.url,
        external_id: { provider: :itunes, identifier: new_external_id }
      ).import
    end

    external_ids = podcast.external_ids.from_itunes.pluck(:identifier)

    assert_equal expected_external_ids.sort, external_ids.sort
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

    podcast
  end
end
