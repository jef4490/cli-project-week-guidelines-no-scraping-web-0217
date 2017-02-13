class Film

  attr_accessor :title, :year, :summary, :author, :articlelink
  attr_reader :movie_data

  @@all = {}

  def initialize(movie_data)
    @movie_data = movie_data
    self.grab_the_data
    @@all[self.title + " (#{self.year})"] = self
  end

  def self.all
    @@all
  end

  def self.clear_results
    @@all = {}
  end

  def self.none?
    self.all == {}
  end

  def grab_the_data
    self.title = self.movie_data.fetch("display_title")
    self.year = self.movie_data.fetch("publication_date")[0..3]
    self.summary = self.movie_data.fetch("summary_short")
    self.author = self.movie_data.fetch("byline")
    self.articlelink = self.movie_data.fetch("link").fetch("url")
  end

end
