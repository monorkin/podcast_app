require "test_helper"

class Podcast::EpisodesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @podcast_episode = podcast_episodes(:remote_ruby_episode_rails_71_is_gonna_be_huge)
  end

  test "should get index" do
    get podcast_episodes_url(podcast_id: @podcast_episode.podcast)
    assert_response :success
  end

  test "should show podcast_episode" do
    get podcast_episode_url(@podcast_episode, podcast_id: @podcast_episode.podcast)
    assert_response :success
  end
end
