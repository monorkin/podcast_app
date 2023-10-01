class Podcast < ApplicationRecord
  has_many :episodes,
    class_name: "Podcast::Episode",
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
