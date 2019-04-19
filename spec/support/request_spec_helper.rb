module RequestSpecHelper
  # Parse JSON response to ruby hash
  def json
    JSON.parse(response.body)
  end

  def valid_headers
    {
      "Authorization" => Rails.application.secrets[:jwt_client_token],
      "Content-Type" => "application/json"
    }
  end
end
