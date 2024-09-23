class BookSearchService
  def self.search_books(location, quantity)
    response = Faraday.get("https://openlibrary.org/search.json") do |req|
      req.params["q"] = location
    end
    json = JSON.parse(response.body, symbolize_names: true)

    json[:docs].first(quantity).map do |book|
      {
        title: book[:title],
        isbn: book[:isbn] || [],
        publisher: book[:publisher] || []
      }
    end
  end
end