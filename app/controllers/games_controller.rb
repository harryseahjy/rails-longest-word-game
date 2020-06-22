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
        @letters_grid = params[:letters_grid]
        @response = ""
        # check the grid
        leftover_letters = @guess.split("") - @letters_grid.split("")
        # check the dictionary
        url = "https://wagon-dictionary.herokuapp.com/#{@guess}"
        html = open(url).read
        rb_text = JSON.parse(html)
        word_exist = rb_text["found"]
        # If statements
        if leftover_letters.length > 0
            @response = "Sorry, but #{@guess} cannot be built out of #{@letters_grid.chars.join(", ").to_s}"
        elsif word_exist == false
            @response = "Sorry, but #{@guess} does not seem to be a valid English word."
        else
            @response = "Congratulations, #{@guess} is a valid English word!"
        end
    end
end

GamesController.new
