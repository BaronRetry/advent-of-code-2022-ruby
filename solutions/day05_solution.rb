
# Read the raw data and parse it into pairs of ranges.
raw_data = File.open("inputs/day05_input.txt").readlines.map(&:chomp)

box_axis_line = raw_data[8]
box_axis_map = Hash[(1..9).map { |val| [val, box_axis_line.index(val.to_s)] }]

def parse_boxes(line, box_axis_map)

  result = {}
  box_axis_map.each do |box_key, box_location|
    box_string = line.split('').values_at(box_location)[0]
    #result[box_key] = box_string
    if box_string == " "
      result[box_key] = nil
    else
      result[box_key] = box_string.to_sym
    end
  end
  result
end

def parse_move(line)
  m = line.match /move (?<n_boxes>\d+) from (?<move_from>\d+) to (?<move_to>\d+)/
  {n_boxes: m["n_boxes"].to_i, move_from: m["move_from"].to_i, move_to: m["move_to"].to_i}
end

def move_boxes(box_arrangement, move)

  n_boxes = move[:n_boxes]
  move_from = move[:move_from]
  move_to = move[:move_to]

  source_boxes = box_arrangement[move_from]
  target_boxes = box_arrangement[move_to]

  n_boxes.times do
    box_to_move = source_boxes.pop
    target_boxes.append(box_to_move)
  end

end

initial_box_arrangement_by_row = raw_data[0..7].reverse.each_with_index.map { |line, i|
  parse_boxes(line, box_axis_map)
}

box_arrangement = {}
(1..9).each do |key|
  new_values = initial_box_arrangement_by_row.map{|row, j| row[key]}
  box_arrangement[key] = new_values.compact
end

moves = raw_data[10..-1].map{|line| parse_move(line)}

moves.each do |move|
  move_boxes(box_arrangement, move)
end

top_boxes = box_arrangement.map{|key, stack| stack[-1]}
top_boxes_str = top_boxes.map(&:to_s).inject('+')

print "The boxes on top of each stack, from 1 to 9, form the following string: #{top_boxes_str}\n"

# Problem 2

def move_boxes_9001(box_arrangement, move)

  n_boxes = move[:n_boxes]
  move_from = move[:move_from]
  move_to = move[:move_to]

  boxes_to_move = box_arrangement[move_from][-n_boxes..-1]
  box_arrangement[move_to].concat(boxes_to_move)
  box_arrangement[move_from] = box_arrangement[move_from][0..-(n_boxes + 1)]

end

box_arrangement_2 = {}
(1..9).each do |key|
  new_values = initial_box_arrangement_by_row.map{|row, j| row[key]}
  box_arrangement_2[key] = new_values.compact
end

moves.each do |move|
  move_boxes_9001(box_arrangement_2, move)
end

top_boxes_2 = box_arrangement_2.map{|key, stack| stack[-1]}
top_boxes_2_str = top_boxes_2.map(&:to_s).inject('+')

print "The boxes on top of each stack, from 1 to 9, form the following string: #{top_boxes_2_str}\n"