require 'net/http'
require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    charset = Array('A'..'Z')
    @letters = Array.new(10) { charset.sample }
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    result = is_word_valid(@word, @letters)
    @score = result[:score]
    @message = result[:message]
  end

  private

  def is_word_valid(word, letters)
    word = word.upcase
    letters_arr = letters.split('')

    # Check if word can be built
    unless word.chars.all? { |char| letters_arr.include?(char) && letters_arr.count(char) >= word.count(char) }
      return { score: 0, message: "Sorry but #{word} can't be built out of #{@letters}." }
    end

    # Check if word is a valid English word
    uri = URI.open("https://wagon-dictionary.herokuapp.com/#{word}").read
    # response = Net::HTTP.get(uri)
    data = JSON.parse(uri)
    unless data['found']
      return { score: 0, message: "The #{word} does not seem to be a valid English word." }
    end

    # Calculate score based on word length
    score = word.length
    { score: score, message: "Congratulations! #{word} is a valid English word!" }
  end
end
