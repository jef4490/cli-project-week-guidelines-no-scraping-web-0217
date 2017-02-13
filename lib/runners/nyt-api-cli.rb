class MovieReviewsCli

  def initialize
    @routine = {"I'm so glad you're here, it's been lonely..." => 3, "Are you having a nice day?" => 1, "Pay attention to me!!!" => 4, "OK fine let's just do a search..." => 1, "What would you like me to search for?" => 0}
  end

  def big_intro
    puts "*"*80
    puts "Welcome to the World's Newest New York Times movie reviews search application!"
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

  def sigh
    sleep (1)
    puts ""
    puts "*Sigh*..."
    puts ""
    sleep (1)
  end

  def run
    NewYorkTimesAPI.clear_results
    Film.clear_results
    print "Search for my movie: "
    input = get_user_input
    # sigh if input.downcase != "help" ||
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
    data = search(input)
    # binding.pry
    return none if Film.none?
    pick_movie_from_options
  end

  def none
    puts "There are no movies matching your search. Please try again!"
  end

  def search(input)
    query = input
    puts "Your search term was #{query.capitalize}, I am searching..."
    # url = "https://api.spotify.com/v1/search?q=#{search_term}&type=track&market=US"
    movies = NewYorkTimesAPI.new(query).create_movie_results
  end

  # def self.maybe_more
  #   3.times {puts "*" *5}
  #   puts "It looks like there may be more results, please try refining your search for more information"
  #   3.times {puts "*" *5}
  # end

  def help
    puts "Type 'exit' to exit"
    puts "Type 'help' to view this menu again"
    puts "Type anything else to search for New York Times movie reviews!"
  end

  def display_selection_options
    Film.all.keys.each.with_index(1) do |title, index|
      if Film.all.count == 1
        puts "#{title}"
      else
      puts "#{index}. #{title}"
    end
  end
  end

  def pick_movie_from_options
    # puts "Presenting Your Movie Details"
    # puts "----" *10
    display_selection_options if Film.all.count > 1
    return selected_movie_information(1) if Film.all.count == 1
    puts "Which movie do you want the review for?"
    NewYorkTimesAPI.all.first.more_results?
    puts "Please input 1 - #{Film.all.count}. If you don't see your movie please input 'refine'."
    selection = get_user_input
    return exit if selection.downcase == "exit" || selection.downcase == "exit!"
    if selection.downcase == "refine"
      run
    else
      if valid?(selection.to_i)
        selected_movie_information(selection.to_i)
      else
        puts "That was not a valid input! Please try again."
        sleep (2)
        puts "Please input 1 - #{Film.all.count}. If you don't see your movie please input 'refine'."
        self.pick_movie_from_options
      end
    end
  end


  def selected_movie_information(selection)
    puts "Presenting Your Movie Details"
    puts "----" *10
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
    system("open #{movie.articlelink}")
  end

  def valid?(num)
    # binding.pry
    num.is_a?(Integer) && (1..Film.all.count).include?(num)
  end

  def self.maybe_more
    puts "!" * 10
    puts "There may be more search results. Consider refining your search query."
    puts "!" * 10
  end

end
