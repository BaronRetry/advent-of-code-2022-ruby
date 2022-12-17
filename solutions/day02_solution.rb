### Advent of Code 2022 - Day 2

## Problem 1

# Define some mappings to help play the game.
opponent_shape_codes = {A: :rock, B: :paper, C: :scissors}
response_shape_codes = {X: :rock, Y: :paper, Z: :scissors}
key_beats_value = {rock: :scissors, paper: :rock, scissors: :paper}
shape_scores = {rock: 1, paper: 2, scissors: 3}
outcome_scores = {lose: 0, draw: 3, win: 6}

# This function takes an array representing the game and a map that says what beats what,
# and returns the outcome of the game.
def rock_paper_scissors(game, game_info)

  opponent = game[0]
  response = game[1]

  opponent_needs = game_info[opponent]
  player_needs = game_info[response]

  # If the opponent plays what the player needs, the player wins.
  # If the player plays what the opponent needs, the player loses.
  # Otherwise, it's a draw.
  if opponent == player_needs
    [response, :win]
  elsif response == opponent_needs
    [response, :lose]
  else
    [response, :draw]
  end

end

# This function takes an array of outcomes and computes the player's score,
# returning the preliminary result as well as the total.
def compute_scores(outcome_data, shape_scores, outcome_scores)

  raw_score_data = outcome_data.map{|game| [shape_scores[game[0]], outcome_scores[game[1]]]}
  score_data = raw_score_data.map(&:sum)
  score = score_data.sum

  [raw_score_data, score_data, score]

end


# Open the strategy file and read the data.
strategy_file = File.open("inputs/day02_input.txt")
strategy_data = strategy_file.readlines.map{|line| line.chomp.split}

# Map the strategy data to symbols defining the opponent and player moves.
named_strategy_data = strategy_data.map{|game| [opponent_shape_codes[game[0].to_sym], response_shape_codes[game[1].to_sym]]}

# " Play the game" by mapping the rock_paper_scissors function across each set of strategy symbols.
outcome_data = named_strategy_data.map{|game| rock_paper_scissors(game, key_beats_value)}

# Compute the results, which are the player scores per game and the total.
q1_results = compute_scores(outcome_data, shape_scores, outcome_scores)

# Print the total.
print "The total score under the assumptions of Problem 1 is #{q1_results[2]}.\n"

## Problem 2

# Define some more mappings to help with this second versino of the problem.
key_loses_to_value = {rock: :paper, paper: :scissors, scissors: :rock}
key_draws_value = {rock: :rock, paper: :paper, scissors: :scissors}
needed_ending_codes = {X: :lose, Y: :draw, Z: :win}

# outcomes_map is a map of every possible outcome of the game.
outcomes_map = {win: key_beats_value.invert,
                lose: key_loses_to_value.invert,
                draw: key_draws_value}

# play_to_outcome returns a result where the player plays whatever move is necessary to achieve the stated outcome.
def play_to_outcome(game, outcomes_map)

  opponent = game[0]
  needed_outcome = game[1]
  needed_to_procure_outcome = outcomes_map[needed_outcome][opponent]

  [needed_to_procure_outcome, needed_outcome]

end

# Now, play the game in similar manner as in Problem 1, only using these new maps and functions we've defined.
new_named_strategy_data = strategy_data.map{|game| [opponent_shape_codes[game[0].to_sym], needed_ending_codes[game[1].to_sym]]}
new_outcome_data = new_named_strategy_data.map{|game| play_to_outcome(game, outcomes_map)}
q2_results = compute_scores(new_outcome_data, shape_scores, outcome_scores)

# Print the total.
print "The total score under the assumptions of Problem 2 is #{q2_results[2]}.\n"