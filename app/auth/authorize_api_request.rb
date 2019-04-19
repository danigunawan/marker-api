class AuthorizeApiRequest
  def initialize(headers = {})
    @headers = headers
  end

  def call
    is_token_valid?
  end

  private

  attr_reader :headers

  def is_token_valid?
    decoded_auth_payload[:client] == JsonWebToken::STATIC_CLIENT_PAYLOAD[:client].to_s
  end

  def decoded_auth_payload
    @decoded_auth_payload ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    end
    raise(ExceptionHandler::MissingToken, Message.missing_token)
  end
end
