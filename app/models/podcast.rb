class Podcast < ApplicationRecord
  has_many :episodes,
    class_name: "Podcast::Episode",
    dependent: :destroy

  validates :url, presence: true, uniqueness: true
  validates :title, presence: true

  class << self
    def from_url(url, options = {})
      podcast = Podcast.find_by(url: url) || Podcast.new(options.merge(url: url))
      podcast.fetch_episodes
      podcast
    end
  end

  def fetch_episodes
    errors.add(:base, "NOT IMPLEMENTED YET")
  end
end
