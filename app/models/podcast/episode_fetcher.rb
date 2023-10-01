class Podcast::EpisodeFetcher
  CHANGABLE_EPISODE_ATTRIBUTES = %w[title description aired_at show_notes audio_file_url].freeze

  include ActiveModel::Model

  attr_accessor :podcast

  delegate :feed, to: :podcast

  def fetch
    new_episodes.each(&:save!)
    changed_episodes.each(&:save!)
  end

  def new_episodes
    new_guids = feed_episode_guid_mappings.keys - podcast.episodes.pluck(:guid)

    new_guids.map do |guid|
      feed_episode_guid_mappings[guid]
    end
  end

  def changed_episodes
    changed_episodes = Set.new

    podcast.episodes.find_each do |episode|
      feed_episode = feed_episode_guid_mappings[episode.guid]
      next if feed_episode.nil?

      episode.attributes = feed_episode.attributes.slice(*CHANGABLE_EPISODE_ATTRIBUTES)
      changed_episodes << episode if episode.changed?
    end

    changed_episodes
  end

  private

    def feed_episode_guid_mappings
      @feed_episode_guid_mappings ||= feed.episodes.each_with_object({}) do |episode, hash|
        hash[episode.guid] = episode
      end
    end
end
