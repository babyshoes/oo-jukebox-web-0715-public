require 'pry'

class Jukebox

  attr_reader :songs
  attr_accessor :continue

  def initialize(songs)
    @songs = songs
    @continue = true
  end

  def welcome
    puts "\nGet yo freak on."
  end

  def call
    welcome
    help
    user_input until @continue == false
  end

  def help
    puts "
          help: if you want to see what Jukebox can do,
          list: if you want to see all Jukebox's songs,
          play: if you want to listen to a song of Jukebox's,
          exit: if you're tired of party"
  end

  def list
    songs.each.with_index(1) {|song, index| puts "#{index}. #{song}"}
  end

  def user_input
    input = gets.strip.downcase
    case
    when input == "help" then help
    when input == "list" then list
    when input == "play" then play
    when input == "exit" then exit
    when input.start_with?("play ") then play(input.gsub("play ", ""))
    when input.to_i < songs.count && input.to_i > 0
      play(input)
    when songs.join(",").downcase.split(",").include?(input)
      play(input)
    else help
    end 
  end

  def play(input=nil)
    # if input == play w/ no specification, ask for user input
    unless input
      puts "What do you wanna listen to?" 
      input = gets.strip.downcase
    end
    # if input == number, play song at that index
    # if input == song title, play specified song
    if songs.join(",").downcase.split(",").include?(input.downcase) ||
      (input.to_i < (songs.count + 1) && input.to_i > 0)
        song = songs.find.with_index(1) {|s, i| input.downcase == s.strip.downcase || input == (i).to_s}
        puts "Now Playing: #{song}"
    end
  end

  def exit
    puts "Bye Bye Bye"
    @continue = false
  end

end