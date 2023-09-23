class PodcastsController < ApplicationController
  before_action :set_podcast, only: %i[ show ]

  # GET /podcasts or /podcasts.json
  def index
    @podcasts = Podcast.all
  end

  # GET /podcasts/1 or /podcasts/1.json
  def show
  end

  # GET /podcasts/new
  def new
    @podcast = Podcast.new
  end

  # POST /podcasts or /podcasts.json
  def create
    @podcast = Podcast.from_url(podcast_params[:url])

    respond_to do |format|
      if @podcast.save
        format.html { redirect_to podcast_url(@podcast), notice: "Podcast was successfully created." }
        format.json { render :show, status: :created, location: @podcast }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @podcast.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_podcast
      @podcast = Podcast.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def podcast_params
      params.require(:podcast).permit(:url)
    end
end
