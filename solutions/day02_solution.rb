
opponent_shape_codes = {A: :rock, B: :paper, C: :scissors}
response_shape_codes = {X: :rock, Y: :paper, Z: :scissors}
key_beats_value = {rock: :scissors, paper: :rock, scissors: :paper}


def rock_paper_scissors(game, game_info)

  opponent = game[0]
  response = game[1]

  opponent_needs = game_info[opponent]
  player_needs = game_info[response]

  if opponent == player_needs
    [response, :win]
  elsif response == opponent_needs
    [response, :lose]
  else
    [response, :draw]
  end

end

def compute_scores(outcome_data, shape_scores, outcome_scores)

  raw_score_data = outcome_data.map{|game| [shape_scores[game[0]], outcome_scores[game[1]]]}
  score_data = raw_score_data.map(&:sum)
  score = score_data.sum

  [raw_score_data, score_data, score]

end

shape_scores = {rock: 1, paper: 2, scissors: 3}
outcome_scores = {lose: 0, draw: 3, win: 6}

strategy_file = File.open("inputs/day02_input.txt")

strategy_data = strategy_file.readlines.map{|line| line.chomp.split}
named_strategy_data = strategy_data.map{|game| [opponent_shape_codes[game[0].to_sym], response_shape_codes[game[1].to_sym]]}
outcome_data = named_strategy_data.map{|game| rock_paper_scissors(game, key_beats_value)}

q1_results = compute_scores(outcome_data, shape_scores, outcome_scores)


key_loses_to_value = {rock: :paper, paper: :scissors, scissors: :rock}
key_draws_value = {rock: :rock, paper: :paper, scissors: :scissors}

outcomes_map = {win: key_beats_value.invert,
                lose: key_loses_to_value.invert,
                draw: key_draws_value}

def play_to_outcome(game, outcomes_map)

  opponent = game[0]
  needed_outcome = game[1]
  needed_to_procure_outcome = outcomes_map[needed_outcome][opponent]

  [needed_to_procure_outcome, needed_outcome]
end



needed_ending_codes = {X: :lose, Y: :draw, Z: :win}
new_named_strategy_data = strategy_data.map{|game| [opponent_shape_codes[game[0].to_sym], needed_ending_codes[game[1].to_sym]]}
new_outcome_data = new_named_strategy_data.map{|game| play_to_outcome(game, outcomes_map)}

q2_results = compute_scores(new_outcome_data, shape_scores, outcome_scores)

print "OK then"