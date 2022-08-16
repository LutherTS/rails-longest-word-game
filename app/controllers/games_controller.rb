require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
  end

  def score
    @response = params[:response].upcase
    @letters = params[:grid]
    @include = include?(@response, @letters)
    @english_word = english_word?(@response)

    # if include?(@response, @letters) == false
    #   @result = "Sorry but #{@response.upcase} can't be built out of #{@letters}."
    # elsif english_word?(@response) == false
    #   @result = "Sorry but #{@response.upcase} does not seem to be a valid English word..."
    # else
    #   @result = "Congratulations! #{@response.upcase} is a valid English word!"
    # end
  end

  def include?(response, letters)
    response.chars.all? do |char|
      response.count(char) <= letters.count(char)
    end
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    json1 = URI.open(url).read
    json2 = JSON.parse(json1)
    json2['found']
  end
end
