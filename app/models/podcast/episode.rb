class Podcast::Episode < ApplicationRecord
  belongs_to :podcast

  delegate :cover_art_url, to: :podcast

  class << self
    def from_feed_item(item, podcast:)
      new(
        podcast: podcast,
        aired_at: item.pubDate,
        title: item.itunes_title.presence || item.title.presence,
        show_notes: item.description.presence,
        audio_file_url: item.enclosure.url
      )
    end
  end
end
