class ErrorMessage
  attr_reader :message, :status

  def initialize(error, status)
    @message = error
    @status = status
  end
end