class Podcast::Episode < ApplicationRecord
  belongs_to :podcast

  delegate :cover_art_url, to: :podcast
end
