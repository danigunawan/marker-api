class ApplicationController < ActionController::API
  include ExceptionHandler

  before_action :authorize_request

  private

  def authorize_request
    AuthorizeApiRequest.new(request.headers).call
  end
end
