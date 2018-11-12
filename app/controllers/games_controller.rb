require 'json'
require 'open-uri'

class GamesController < ApplicationController
  LETTERS = 10.times.map { ("A".. "Z").to_a.sample }.join
  def new
    @letters = LETTERS
  end

  def score
    @word = params[:word]
    word_array = @word.downcase.split""
    if word_array.all? {|letter| LETTERS.downcase.include?(letter)} && validation
      @result = "Congratulations! #{@word} is a valid English word"
    elsif word_array.all? {|letter| LETTERS.downcase.include?(letter)} && !validation
      @result = "Sorry but #{@word} does not seem to be a valid English word..."
    else
      @result = "Sorry but #{@word} cannt be build out of #{LETTERS}"
    end
  end

  def validation
    url = "https://wagon-dictionary.herokuapp.com/#{@word.downcase}"
    file = open(url).read
    validation_result = JSON.parse(file)
    validation_result["found"]
  end
end
