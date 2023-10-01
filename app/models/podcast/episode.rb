class Podcast::Episode < ApplicationRecord
  belongs_to :podcast

  validates :aired_at, presence: true
  validates :audio_file_url, presence: true
  validates :guid, presence: true, uniqueness: { scope: :podcast_id }
  validates :title, presence: true

  delegate :cover_art_url, to: :podcast
end
