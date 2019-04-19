class UniqueCoordinates < ActiveModel::Validator
  def validate(record)
    raise ExceptionHandler::DuplicateMarkerError if Marker.where(lat: record.lat, long: record.long).exists?
  end
end


class Marker < ApplicationRecord
  # belongs_to :user
  validates_presence_of :lat, :long
  validates_with UniqueCoordinates
end
