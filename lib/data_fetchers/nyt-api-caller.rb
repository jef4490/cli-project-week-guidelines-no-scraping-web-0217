require 'pry'
require 'uri'

class NewYorkTimesAPI

  attr_reader :uri, :search_results, :query

  @@all = []

  def initialize(query)

    @query = query
    @uri = URI("https://api.nytimes.com/svc/movies/v2/reviews/search.json")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    uri.query = URI.encode_www_form({
      "api-key" => "8f6d1b8fa5014254bd71c5dcde263296",
      "query" => self.query
    })
    request = Net::HTTP::Get.new(uri.request_uri)
    @search_results = JSON.parse(http.request(request).body)
    @@all << self
  end

  def create_movie_results
    self.search_results.fetch("results").each do |movie_hash|
      movie = Film.new(movie_hash)
    end
    # MovieReviewsCli.maybe_more if self.search_results.fetch("has_more")
    Film.all
  end

  def more_results?
    MovieReviewsCli.maybe_more if self.search_results.fetch("has_more")
  end

  def self.clear_results
    @@all = []
  end

  def self.all
    @@all
  end

  # def make_albums
  #   albums = []
  #   all_albums = music_data["tracks"]["items"]
  #   all_albums.each do |album|
  #     album_name = album["name"]
  #     albums << ExampleModel.new(album_name)
  #   end
  #   albums
  # end

end
