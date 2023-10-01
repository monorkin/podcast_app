require "test_helper"

class PodcastsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @podcast = podcasts(:remote_ruby)
  end

  test "should get index" do
    get podcasts_url
    assert_response :success
  end

  test "should get new" do
    get new_podcast_url
    assert_response :success
  end

  test "should create podcast" do
    stub_feed_request_for "https://example.com/feed", with: Pathname.new(file_fixture_path).join("example_feed.xml")

    assert_difference("Podcast.count") do
      post podcasts_url, params: { podcast: { url: "https://example.com/feed" } }
    end

    assert_redirected_to podcast_url(Podcast.last)
  end

  test "should show podcast" do
    get podcast_url(@podcast)
    assert_response :success
  end
end
