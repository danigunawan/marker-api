require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  RN_CLIENT_TOKEN = Rails.application.secrets[:jwt_client_token]

  describe "#authorize_request" do
    context "when auth token is passed" do
      let(:headers) { { 'Authorization' => RN_CLIENT_TOKEN } }
      before do
        allow(request).to receive(:headers).and_return(headers)
      end

      it "passes auth checks succesfully" do
        expect do
          subject.instance_eval { authorize_request }
        end.not_to raise_error
      end
    end

    context "when auth token is not passed" do
      let(:missing_auth_headers) { { 'Authorization' => nil } }
      before do
        allow(request).to receive(:headers).and_return(missing_auth_headers)
      end

      it "raises MissingToken error" do
        expect do
          subject.instance_eval { authorize_request }
        end.to raise_error(ExceptionHandler::MissingToken, /Missing token/)
      end
    end

    context "when invalid auth token is passed" do
      let(:invalid_headers) { { 'Authorization' => 'foobar' } }
      before do
        allow(request).to receive(:headers).and_return(invalid_headers)
      end

      it "raises InvalidToken error" do
        expect do
          subject.instance_eval { authorize_request }
        end.to raise_error(ExceptionHandler::InvalidToken)
      end
    end
  end
end
