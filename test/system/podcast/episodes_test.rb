require "application_system_test_case"

class Podcast::EpisodesTest < ApplicationSystemTestCase
  setup do
    @podcast_episode = podcast_episodes(:one)
  end

  test "visiting the index" do
    visit podcast_episodes_url
    assert_selector "h1", text: "Episodes"
  end

  test "should create episode" do
    visit podcast_episodes_url
    click_on "New episode"

    fill_in "Aired at", with: @podcast_episode.aired_at
    fill_in "Audo file url", with: @podcast_episode.audo_file_url
    fill_in "Podcast", with: @podcast_episode.podcast_id
    fill_in "Show notes", with: @podcast_episode.show_notes
    fill_in "Title", with: @podcast_episode.title
    click_on "Create Episode"

    assert_text "Episode was successfully created"
    click_on "Back"
  end

  test "should update Episode" do
    visit podcast_episode_url(@podcast_episode)
    click_on "Edit this episode", match: :first

    fill_in "Aired at", with: @podcast_episode.aired_at
    fill_in "Audo file url", with: @podcast_episode.audo_file_url
    fill_in "Podcast", with: @podcast_episode.podcast_id
    fill_in "Show notes", with: @podcast_episode.show_notes
    fill_in "Title", with: @podcast_episode.title
    click_on "Update Episode"

    assert_text "Episode was successfully updated"
    click_on "Back"
  end

  test "should destroy Episode" do
    visit podcast_episode_url(@podcast_episode)
    click_on "Destroy this episode", match: :first

    assert_text "Episode was successfully destroyed"
  end
end
