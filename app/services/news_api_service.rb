class NewsAPIService
  def initialize(api_key = Rails.application.credentials[:NEWS_API_KEY])
    @news_api = News.new(api_key)
  end

  def fetch_top_articles(representative_name, issue)
    query = "#{representative_name} #{issue}"
    @news_api.get_top_headlines(q: query, language: 'en', country: 'us')
  end
end
