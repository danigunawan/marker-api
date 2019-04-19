class JsonWebToken
  # secret to encode and decode token
  SHARED_SECRET = Rails.application.secrets[:jwt_shared_secret]
  STATIC_CLIENT_PAYLOAD = { client: :reactnative }

  # TODO:
  # Currently a static encoded access token (generated once) is shared with the client.
  # This can easily be scaled to generated on-demand tokens with user-specific payloads
  # and an expiry
  def self.encode(payload = STATIC_CLIENT_PAYLOAD)
    # sign token with a secret shared between clients and API server
    byebug
    JWT.encode(payload, SHARED_SECRET)
  end

  def self.decode(access_token)
    # get payload; first index in decoded Array
    body = JWT.decode(access_token, SHARED_SECRET)[0]
    HashWithIndifferentAccess.new body
    # rescue from all decode errors
  rescue JWT::DecodeError => e
    # raise custom error to be handled by custom handler
    raise ExceptionHandler::InvalidToken, e.message
  end
end
