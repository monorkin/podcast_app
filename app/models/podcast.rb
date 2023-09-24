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
    def from_url(url, options = {})
      Podcast.new(options.merge(url: url)).tap do |podcast|
        podcast.title = podcast.feed.title
        podcast.description = podcast.feed.description
        podcast.cover_art_url = podcast.feed.cover_art_url
      end
    end
  end

  def fetch_episodes_later
    Podcast::EpisodeFetcherJob.perform_later(self)
  end

  def fetch_episodes
    # TODO: Find some better way to figure out which episodes to import
    latest_episode = episodes.order(aired_at: :desc).first

    feed.episodes.each do |episode|
      next if latest_episode && episode.aired_at.before?(latest_episode.aired_at)

      episode.save!
    end
  end

  def feed
    @feed ||= Feed.new(podcast: self)
  end
end
