class ErrorMessage
  attr_reader :message, :status

  def initialize(error, status)
    @message = error.message
    @status = status
  end
end