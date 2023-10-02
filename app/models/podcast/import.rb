class Podcast::Import
  include ActiveModel::Model

  attr_accessor :url, :external_id

  class << self
    def from_url(url)
      new(url: url).import
    end

    def from_itunes(url:, collection_id:)
      new(
        url: url,
        external_id: { provider: :itunes, identifier: collection_id }
      ).import
    end
  end

  def import
    podcast.save! unless podcast.persisted?
    podcast
  end

  private

    def podcast
      @podcast ||= (find_podcast || build_podcast)
    end

    def find_podcast
      podcast_by_url = Podcast.find_by(url: url)

      if external_id.present? && url.present?
        return (podcast_by_url || Podcast::ExternalId.find_by(external_id)&.podcast)
      end

      podcast_by_url
    end

    def build_podcast
      Podcast.new(url: url).tap do |podcast|
        feed = podcast.feed

        podcast.title = feed.title
        podcast.description = feed.description
        podcast.cover_art_url = feed.cover_art_url

        podcast.external_ids.new(external_id) if external_id.present?
      end
    end
end
