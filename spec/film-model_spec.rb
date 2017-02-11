describe 'class Film' do

  let (:film) { Film.new }

    it "doesn't raise an error" do
      y = NewYorkTimesAPI.new("Home Alone")
      y.create_movie_results
      # x = Film.new("data")
      # expect(NewYorkTimesAPI.all).to include(:API_requestor)
    end



  # before(:each) usually goes up top, for example:
  # before(:each) do
  #   Genre.reset_all
  # end

  # let statements usually go here, for example:
  # let(:artist) { Artist.new }

  # it statements look like this:
  # it "can have a song added" do
  #   artist.add_song(song)
  #   expect(artist.songs).to include(song)
  # end

  it "I changed this boolean to true when I finished this lab" do
    done = false
    expect(done).to eq(true)
  end

end
