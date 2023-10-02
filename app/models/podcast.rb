require "net/http"

class Podcast < ApplicationRecord
  has_many :episodes,
    class_name: "Podcast::Episode",
    dependent: :destroy
  has_many :external_ids,
    class_name: "Podcast::ExternalId",
    dependent: :destroy

  validates :url, presence: true, uniqueness: true
  validates :title, presence: true

  after_commit on: :create do
    fetch_episodes_later
  end

  class << self
    def import_from_url(url)
      Import.from_url(url)
    end

    def import_from_itunes(url:, collection_id:)
      Import.from_itunes(url: url, collection_id: collection_id)
    end

    def search_for(podcast_name)
      search_url = "https://itunes.apple.com/search"

      uri = URI(search_url)
      uri.query = { term: podcast_name, entity: "podcast", limit: 3 }.to_query

      response = Net::HTTP.get(uri)
      JSON.parse(response)["results"].map do |result|
        Podcast.import_from_itunes(url: result["feedUrl"], collection_id: result["collectionId"])
      end
    end
  end

  def fetch_episodes_later
    EpisodeFetcherJob.perform_later(self)
  end

  def fetch_episodes
    EpisodeFetcher.new(podcast: self).fetch
  end

  def feed
    @feed ||= Feed.new(podcast: self)
  end
end
