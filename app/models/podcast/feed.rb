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
      Podcast::Episode.from_feed_item(item, podcast: podcast)
    end
  end

  private

    def feed
      @feed ||= RSS::Parser.parse(rss_xml, validate: false)
    end

    def rss_xml
      # TODO: follow redirects
      @rss_xml ||= Net::HTTP.get(URI(url))
    end
end
