require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  RN_CLIENT_TOKEN = Rails.application.secrets[:jwt_client_token]

  # Mock `Authorization` header
  let(:header) { { 'Authorization' => RN_CLIENT_TOKEN } }

  # Invalid request subject
  subject(:invalid_request_obj) { described_class.new({}) }

  # Valid request subject
  subject(:request_obj) { described_class.new(header) }


  describe '#call' do
    context 'when valid request' do
      it 'passes auth check' do
        result = request_obj.call
        expect(result).to eq(true)
      end
    end

    context 'when invalid request' do
      context 'when missing token' do
        it 'raises a MissingToken error' do
          expect { invalid_request_obj.call }
            .to raise_error(ExceptionHandler::MissingToken, 'Missing token')
        end
      end

      context 'when invalid/fake token' do
        let(:header) { { 'Authorization' => 'foobar' } }
        subject(:invalid_request_obj) { described_class.new(header) }

        it 'handles JWT::DecodeError' do
          expect { invalid_request_obj.call }
            .to raise_error(
              ExceptionHandler::InvalidToken,
              /Not enough or too many segments/
            )
        end
      end
    end
  end
end
