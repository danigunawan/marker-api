class MarkersController < ApplicationController
  def index
    @markers = Marker.all
    render json: @markers, status: :ok
  end

  def create
    @marker = Marker.create!(marker_params)
    render json: @marker, status: :created
  end

  def delete
    @markers = Marker.where(marker_params)
    raise ActiveRecord::RecordNotFound unless @markers.exists?
    @markers.first.destroy!
    head :no_content
  end

  private

  def marker_params
    params.permit(:lat, :long)
  end
end
