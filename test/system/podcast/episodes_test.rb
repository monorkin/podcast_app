require "application_system_test_case"

class Podcast::EpisodesTest < ApplicationSystemTestCase
  setup do
    @podcast_episode = podcast_episodes(:remote_ruby_episode_rails_71_is_gonna_be_huge)
    @podcast = @podcast_episode.podcast
  end

  test "visiting the index" do
    visit podcast_episodes_url(podcast_id: @podcast)
    assert_selector "h1", text: "Episodes"
  end
end
