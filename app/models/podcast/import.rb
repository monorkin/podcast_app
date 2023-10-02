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
    podcast.url = url
    podcast.external_ids.new(external_id) if new_external_id?

    if podcast.url_changed? || podcast.new_record?
      feed = podcast.feed

      podcast.title = feed.title
      podcast.description = feed.description
      podcast.cover_art_url = feed.cover_art_url
    end

    podcast.save!
    podcast
  end

  private

    def podcast
      @podcast ||= (find_podcast || Podcast.new(url: url))
    end

    def find_podcast
      podcast = Podcast.find_by(url: url)

      if external_id.present? && url.present?
        return (podcast || Podcast::ExternalId.find_by(external_id)&.podcast)
      end

      podcast
    end

    def new_external_id?
      external_id.present? && podcast.external_ids.find_by(external_id).blank?
    end
end
