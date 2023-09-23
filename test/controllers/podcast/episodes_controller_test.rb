require "test_helper"

class Podcast::EpisodesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @podcast_episode = podcast_episodes(:one)
  end

  test "should get index" do
    get podcast_episodes_url
    assert_response :success
  end

  test "should get new" do
    get new_podcast_episode_url
    assert_response :success
  end

  test "should create podcast_episode" do
    assert_difference("Podcast::Episode.count") do
      post podcast_episodes_url, params: { podcast_episode: { aired_at: @podcast_episode.aired_at, audo_file_url: @podcast_episode.audo_file_url, podcast_id: @podcast_episode.podcast_id, show_notes: @podcast_episode.show_notes, title: @podcast_episode.title } }
    end

    assert_redirected_to podcast_episode_url(Podcast::Episode.last)
  end

  test "should show podcast_episode" do
    get podcast_episode_url(@podcast_episode)
    assert_response :success
  end

  test "should get edit" do
    get edit_podcast_episode_url(@podcast_episode)
    assert_response :success
  end

  test "should update podcast_episode" do
    patch podcast_episode_url(@podcast_episode), params: { podcast_episode: { aired_at: @podcast_episode.aired_at, audo_file_url: @podcast_episode.audo_file_url, podcast_id: @podcast_episode.podcast_id, show_notes: @podcast_episode.show_notes, title: @podcast_episode.title } }
    assert_redirected_to podcast_episode_url(@podcast_episode)
  end

  test "should destroy podcast_episode" do
    assert_difference("Podcast::Episode.count", -1) do
      delete podcast_episode_url(@podcast_episode)
    end

    assert_redirected_to podcast_episodes_url
  end
end
