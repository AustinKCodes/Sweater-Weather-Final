class ErrorSerializer
  def self.serialize(error)
    {
      error: {
        message: error.message,
        status: error.status
      }
    }
  end
end