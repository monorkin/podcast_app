class Podcast::Import
  include ActiveModel::Model

  attr_accessor :url

  class << self
    def from_url(url)
      new(url: url).import
    end
  end

  def import
    podcast.save!
    podcast
  end

  private

    def podcast
      @podcast ||= find_or_build_podcast
    end

    def find_or_build_podcast
      Podcast.find_or_initialize_by(url: url).tap do |podcast|
        feed = podcast.feed

        podcast.title = feed.title
        podcast.description = feed.description
        podcast.cover_art_url = feed.cover_art_url
      end
    end
end
