class Podcast::EpisodesController < ApplicationController
  before_action :set_podcast, only: %i[ show index ]
  before_action :set_podcast_episode, only: %i[ show ]

  # GET /podcast/episodes or /podcast/episodes.json
  def index
    @podcast_episodes = @podcast.episodes
  end

  # GET /podcast/episodes/1 or /podcast/episodes/1.json
  def show
  end

  private

    def set_podcast_episode
      @podcast_episode = @podcast.episodes.find(params[:id])
    end

    def set_podcast
      @podcast = Podcast.find(params[:podcast_id])
    end
end
