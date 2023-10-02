class Podcast::ExternalId < ApplicationRecord
  PROVIDERS = {
    itunes: 0
  }.freeze

  belongs_to :podcast

  enum :provider, PROVIDERS, prefix: :from

  validates :provider, presence: true
  validates :identifier, presence: true, uniqueness: { scope: :provider }
end
