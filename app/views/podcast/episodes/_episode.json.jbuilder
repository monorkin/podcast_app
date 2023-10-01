json.extract! podcast_episode, :id, :podcast_id, :cover_art_url, :aired_at, :title, :show_notes, :audio_file_url, :guid, :created_at, :updated_at
json.url podcast_episode_url(podcast_episode, podcast_id: podcast_episode.podcast, format: :json)
json.podcast_url podcast_url(podcast_episode.podcast, format: :json)
