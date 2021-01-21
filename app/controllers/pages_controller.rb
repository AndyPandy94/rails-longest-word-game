require 'json'
require 'open-uri'

class PagesController < ApplicationController
  def game
    @array = Array.new(10) { ('A'..'Z').to_a.sample }.join(" ")
  end

  def score
    @answer = params[:answer].upcase
    @array = params[:array]
    # @response = check_answer(@answer,@array)
    @included = include_grid?(@answer, @array)
    @check = check_words(@answer)
  end

  private


  def include_grid?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
    # word.chars is turning it into an array
    # word.count(letter) is how many times each |letter| is being counted
    # letters.count(letter) is how many that letter from the word is in that grid
  end


  def check_words(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    result = JSON.parse(open(url).read)
    result["found"]
  end

  # def check_answer(word, letters)
  #    if check_words(word) && include_grid?(word, letters)
  #      'Well done!'

  #    elsif check_words(word) && !include_grid?(word, letters)
  #      'Word is not part of the grid'

  #    else
  #      'Incorrect word!'
  #    end
  # end

end
