class Podcast::EpisodesController < ApplicationController
  before_action :set_podcast_episode, only: %i[ show ]

  # GET /podcast/episodes or /podcast/episodes.json
  def index
    @podcast_episodes = Podcast::Episode.all
  end

  # GET /podcast/episodes/1 or /podcast/episodes/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_podcast_episode
      @podcast_episode = Podcast::Episode.find(params[:id])
    end
end
