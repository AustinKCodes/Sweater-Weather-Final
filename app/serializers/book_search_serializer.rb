class BookSearchSerializer
  def initialize(location, forecast, books)
    @location = location
    @forecast = forecast
    @books = books
  end

  def serialized_json
    {
      data: {
        id: nil,
        type: "books",
        attributes: {
          destination: @location,
          forecast: {
            summary: @forecast[:summary],
            temperature: @forecast[:temperature]
          },
          total_books_found: @books.size,
          books: @books
        }
      }
    }
  end
end