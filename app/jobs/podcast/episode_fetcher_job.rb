class Podcast::EpisodeFetcherJob < ApplicationJob
  queue_as :default

  def perform(podcast)
    podcast.fetch_episodes
  end
end
