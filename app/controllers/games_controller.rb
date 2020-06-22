class GamesController < ApplicationController

    def new
        # generate random letters
        alphabet = ("A".."Z").to_a
        @letters = alphabet.sample(9)
    end

    def score
        require 'json'
        require 'open-uri'
        @guess = params[:guess]
        @guess.upcase! unless @guess == nil
        @letters = params[:letters]
        @response = ""
        session[:score] == nil ? @score = 0 : @score = session[:score]
        # check the grid
        leftover_letters = @guess.split("") - @letters.split("")
        # check the dictionary
        url = "https://wagon-dictionary.herokuapp.com/#{@guess}"
        html = open(url).read
        rb_text = JSON.parse(html)
        word_exist = rb_text["found"]
        # If statements
        if leftover_letters.length > 0
            @response = "Sorry, but #{@guess.upcase} cannot be built out of #{@letters.chars.join(", ").to_s}"
        elsif word_exist == false
            @response = "Sorry, but #{@guess.upcase} does not seem to be a valid English word."
        else
            @response = "Congratulations, #{@guess.upcase} is a valid English word!"
            @score += @guess.chars.length
            # session[:score] = @score
        end
    end
end

GamesController.new
