class MovieReviewsCli

  def initialize
    @routine = {"I'm so glad you're here, it's been lonely..." => 3, "Are you have a nice day?" => 1, "Nevermind. That's not why you're here..." => 1, "What would you like me to search for?" => 0}
  end

  def big_intro
    puts "Welcome to the world's newest New York Times movie reviews search application!"
    puts "*"*80
  end

  def ramble
    self.computer_insecurity.each do |str, slp|
      puts str
      puts ""
      sleep(slp)
    end
  end

  attr_reader :routine

  def computer_insecurity
    self.routine
  end

  def call
    big_intro
    ramble
    run
  end

  def get_user_input
    gets.chomp.strip
  end

  def run
    print "New search keyword: "
    input = get_user_input
    if input == "help"
      help
    elsif input == "exit"
      puts "Please come back soon..."
      sleep (2)
      puts "please"
      sleep (2)
      exit
    elsif input == "exit!"
      exit
    else
      search_and_return_movie_review(input)
    end
    run
  end

  def search_and_return_movie_review(input)
    search(input)
    pick_movie_from_options
  end

  def search(input)
    query = input
    puts "Your search term was #{query.capitalize}, I am searching..."
    # url = "https://api.spotify.com/v1/search?q=#{search_term}&type=track&market=US"
    movies = NewYorkTimesAPI.new(query).create_movie_results
  end

  def self.maybe_more
    3.times {puts "*" *5}
    puts "It looks like there may be more results, please try refining your search for more information"
    3.times {puts "*" *5}
  end

  def help
    puts "Type 'exit' to exit"
    puts "Type 'help' to view this menu again"
    puts "Type anything else to search for New York Times movie reviews!"
  end

  def display_selection_options
    Film.all.keys.each.with_index(1) do |title, index|
      puts "#{index}. #{title}"
    end
  end

  def pick_movie_from_options
    puts "Here are the results of your search"
    puts "*" *30
    display_selection_options
    puts "Which movie do you want the review for?"
    puts "Please input 1 - #{Film.all.count}"
    selection = get_user_input.to_i
    if valid?(selection)
      puts "Grabbing information..."
      selected_movie_information(selection)
    end
  end

  def selected_movie_information(selection)
    movie_key = Film.all.keys[selection - 1]
    movie = Film.all.fetch(movie_key)
    display_movie_details(movie)
  end

  def display_movie_details(movie)
    # binding.pry
    puts "Title: " + movie.title
    puts "Year: " + movie.year
    puts "Summary: " + movie.summary
    puts "Reviewer: " + movie.author
    puts "Review: " + movie.articlelink
  end

  def valid?(num)
    binding.pry
    num.is_a?(Integer) && (1..Film.all.count).include?(num)
  end

end
