require 'open-uri'
require 'json'
class GamesController < ApplicationController


  def game
    @grid = generate_grid(9).join
  end


  def score
    @start_time = params[:start_time].to_datetime
    @end_time = Time.now.to_datetime
    result_hash = run_game(params[:query], @grid, @start_time, @end_time)
    @result = result_hash[:score]
    @message = result_hash[:message]
    end




  def generate_grid(size)

   Array.new(size){[*"A".."Z"].sample}
 end

 def includer(reference,element)
  att_included = false
  element.each do |char|
    att_included = true unless reference.include? char.upcase
    reference.delete(char.upcase)
  end
  return att_included
  # p reference
  # p element
  #  if (reference & element) == element
  #  return true
  #  else return false
  # end
end



def run_game(attempt, grid, start_time, end_time)
  result = {}
  word_raw = open("https://wagon-dictionary.herokuapp.com/#{attempt}").read
  json_word = JSON.parse(word_raw)
  attempt_array = attempt.chars


  if(!json_word["found"])
    result[:time] = end_time - start_time
    result[:score] = 0
    result[:message] = "not an english word"

  #elsif sorted_grid.include?(sorted_attempt) == false
elsif includer(grid,attempt_array)

  result[:time] = end_time - start_time
  result[:score] = 0
  result[:message] = "You have used letters that are not in the grid"


else

  result[:time] = end_time - start_time
  result[:score] = (attempt.size) * 0.4 + (30 - result[:time] ) * 0.1
  result[:message] = "Well Done!"

end
result
  # TODO: runs the game and return detailed hash of result
end

end
