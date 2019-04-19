require 'rails_helper'

RSpec.describe 'Markers API', type: :request do
  let!(:markers) { create_list(:marker, 5) }
  let(:marker_id) { markers.first.id }
  let(:headers) { valid_headers }

  describe 'GET /markers' do
    before { get '/markers', headers: headers }

    it 'returns markers' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'resolves with status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /markers' do
    SAMPLE_LAT = 52.520008
    SAMPLE_LONG = 13.404954
    let(:valid_attributes) { { lat: SAMPLE_LAT, long: SAMPLE_LONG }.to_json }

    context 'when request payload is valid' do
      before { post '/markers', params: valid_attributes, headers: headers }

      it 'creates the given marker' do
        expect(Marker.last.lat).to eq(SAMPLE_LAT)
        expect(Marker.last.long).to eq(SAMPLE_LONG)
      end

      it 'returns the marker' do
        expect(json['lat']).to eq(SAMPLE_LAT.to_s)
        expect(json['long']).to eq(SAMPLE_LONG.to_s)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request payload is invalid' do
      before { post '/markers', params: { lat: SAMPLE_LAT }.to_json, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Long can't be blank/)
      end
    end
  end

  describe 'DELETE /markers/:id' do
    before { delete "/markers/#{marker_id}", headers: headers }

    it 'deletes the marker' do
      expect do
        Marker.find(marker_id)
      end.to raise_error ActiveRecord::RecordNotFound
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
