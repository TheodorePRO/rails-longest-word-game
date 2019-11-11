require 'JSON'
require 'open-uri'

class GamesController < ApplicationController
  # @url = "https://wagon-dictionary.herokuapp.com/"

  def new
    @letters = g_letters
  end

  def score
    @word = params[:name]
    @letters = params[:letters]
    @result = result(@word, @letters)
  end

  def include?(word, letters)
    @word.chars.all? { |a|  @word.chars.count(a) <= letters.count(a) }
  end

  def result(word, letters)
    return 'not in doco' if include?(word, letters)
    return "sorry #{word} is not an English word" unless english(word)
    return 'congrads'
  end

  def g_letters
    array_letters = []
    10.times { array_letters << rand(65..90).chr }
    return array_letters
  end

  def english(word)
    english = open("https://wagon-dictionary.herokuapp.com/#{word}").read
    return JSON.parse(english)['found']
  end
end
