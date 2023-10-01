require "application_system_test_case"

class PodcastsTest < ApplicationSystemTestCase
  setup do
    @podcast = podcasts(:remote_ruby)
  end

  test "visiting the index" do
    visit podcasts_url
    assert_selector "h1", text: "Podcasts"
  end

  test "should create podcast" do
    @podcast.destroy!
    stub_feed_request_for(@podcast.url,
      with: Pathname.new(file_fixture_path).join("modified_remote_ruby_feed.xml"))

    visit podcasts_url
    click_on "New podcast"

    fill_in "Url", with: @podcast.url
    click_on "Create Podcast"

    assert_current_path podcast_url(Podcast.order(created_at: :desc).first)
    assert_text "Podcast was successfully created"
    click_on "Back"
  end
end
