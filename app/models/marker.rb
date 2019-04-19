class Marker < ApplicationRecord
  # belongs_to :user
  validates_presence_of :lat, :long
end
