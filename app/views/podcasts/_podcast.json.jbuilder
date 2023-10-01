json.extract! podcast, :id, :cover_art_url, :title, :created_at, :updated_at
json.feed_url podcast.url
json.url podcast_url(podcast, format: :json)
json.episodes_url podcast_episodes_url(podcast, format: :json)
