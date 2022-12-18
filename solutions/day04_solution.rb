### Advent of Code 2022 - Day 4

## Problem 1

# Define compare_ranges to check if one range completely covers another.
def compare_ranges(x, y)
  x.cover?(y) or y.cover?(x)
end

# Read the raw data and parse it into pairs of ranges.
raw_sections_data = File.open("inputs/day04_input.txt").readlines.map(&:chomp)
sections_data = raw_sections_data.map{|line| line.split(',').map{|range| range.split('-').map(&:to_i)}}
ranges_data = sections_data.map{|values| values.map{|pair| Range.new(pair[0], pair[1])}}

# Use compare_ranges to check in how many cases one range covers the other.
ranges_contain_ranges_data = ranges_data.map{|values| compare_ranges(values[0], values[1])}
ranges_contain_ranges_scores = ranges_contain_ranges_data.map{|value| if value then 1 else 0 end}
q1_total = ranges_contain_ranges_scores.sum

print "There are #{q1_total} cleanup assignments where one section completely contains another.\n"


# Problem 2

# Define new_compare_ranges to check if one section overlaps another at all.
def new_compare_ranges(x, y)

  if (x.to_a & y.to_a).length > 0
    true
  else
    false
  end

end

# Repeat the calculations from above, but use new_compare_ranges instead.
ranges_touch_ranges_data = ranges_data.map{|values| new_compare_ranges(values[0], values[1])}
ranges_touch_ranges_scores = ranges_touch_ranges_data.map{|value| if value then 1 else 0 end}
q2_total = ranges_touch_ranges_scores.sum

print "There are #{q2_total} cleanup assignments where one section overlaps with another.\n"
