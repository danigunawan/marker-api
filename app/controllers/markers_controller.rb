class MarkersController < ApplicationController
  before_action :set_marker, only: [:destroy]

  def index
    @markers = Marker.all
    render json: @markers, status: :ok
  end

  def create
    @marker = Marker.create!(marker_params)
    render json: @marker, status: :created
  end

  def destroy
    @marker.destroy
    head :no_content
  end

  private

  def marker_params
    params.permit(:lat, :long)
  end

  def set_marker
    @marker = Marker.find(params[:id])
  end
end
