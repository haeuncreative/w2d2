require 'byebug'

class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]


  attr_reader :guess_word, :attempted_chars, :remaining_incorrect_guesses, 

  def self.random_word
    return DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = Array.new
    @remaining_incorrect_guesses = 5
  end

  def already_attempted?(char)
    if @attempted_chars.include?(char)
      return true
    else
      return false
    end
  end

  def get_matching_indices(char)
    secret_chars = @secret_word.split("")
    index_arr = Array.new
    secret_chars.each_with_index do |s_char, i|
      if s_char == char
        index_arr << i
      end
    end

    return index_arr

  end

  def fill_indices(char, arr)
    arr.each do |i|
      @guess_word[i] = char
    end
  end

  def try_guess(char)
    if self.already_attempted?(char)
      p 'that has already been attempted'
      return false
    else
      @attempted_chars << char
      matchy = self.get_matching_indices(char)
      if matchy.empty?
        @remaining_incorrect_guesses -= 1
        return true
      else
        self.fill_indices(char, matchy)
        return true
      end
    end
  end

  def ask_user_for_guess
    p 'Enter a char:'
    input = gets.chomp
    value = self.try_guess(input)
  end

  def win?
    if @secret_word == @guess_word.join("")
      p 'WIN'
      return true
    else
      return false
    end
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      p 'LOSE'
      return true
    else
      return false
    end
  end

  def game_over?
    if self.win? || self.lose?
      p @secret_word
      return true
    else
      return false
    end
  end


end
