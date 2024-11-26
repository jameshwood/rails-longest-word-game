require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @answer = params[:answer]
    letters = JSON.parse(params[:letters])
    answer_array = @answer.chars
    valid = true
    answer_array.each do |letter|
     if letters.include?(letter.upcase)
      letters.delete_at(letters.index(letter.upcase))
     else
      valid = false
      break
     end
    end
    if valid
      url = "https://dictionary.lewagon.com/#{@answer}"
      word_check = JSON.parse(URI.parse(url).open.read)
      if word_check['found']
        @score = @answer.length
      else
        @score = 0
      end
    else
      @score = 0
    end
  end
end
