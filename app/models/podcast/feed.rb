require "rss"
require "net/http"

class Podcast::Feed
  include ActiveModel::Model

  attr_accessor :podcast

  delegate :url, to: :podcast

  def cover_art_url
    feed.channel.itunes_image&.href.presence ||
      feed.channel.image&.url.presence
  end

  def title
    feed.channel.title.presence ||
      feed.channel.itunes_title.presence
  end

  def description
    feed.channel.description.presence ||
      feed.channel.itunes_summary.presence ||
      feed.channel.itunes_subtitle.presence
  end

  def episodes
    feed.channel.items.each.lazy.map do |item|
      build_episode_from_item(item)
    end
  end

  private

    def build_episode_from_item(item)
      Podcast::Episode.new(
        podcast: podcast,
        guid: item.guid.content.presence,
        aired_at: item.pubDate,
        title: item.itunes_title.presence || item.title.presence,
        show_notes: item.description.presence,
        audio_file_url: item.enclosure.url
      )
    end

    def feed
      @feed ||= RSS::Parser.parse(rss_xml, validate: false)
    end

    def rss_xml
      @rss_xml ||= Net::HTTP.get(URI(url))
    end
end
