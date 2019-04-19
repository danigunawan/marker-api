require 'rails_helper'

RSpec.describe Marker, type: :model do
  it { should validate_presence_of(:lat) }
  it { should validate_presence_of(:long) }
end
