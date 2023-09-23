json.extract! podcast, :id, :url, :cover_art_url, :title, :created_at, :updated_at
json.url podcast_url(podcast, format: :json)
