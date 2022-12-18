### Advent of Code 2022 - Day 3

## Problem 1

# Build the lookup table of letters to priority values.
lowercase_priorities_lookup = Hash[("a".."z").map { |char| [char, char.ord - "a".ord + 1] }]
uppercase_priorities_lookup = Hash[("A".."Z").map { |char| [char, char.ord - "'".ord + 1] }]
priorities_lookup = lowercase_priorities_lookup.merge(uppercase_priorities_lookup)

# Define a function to find_the (assumed single) shared item between two rucksack compartments.
def find_shared_item(compartment_1, compartment_2)

  chars_1 = compartment_1.split('')
  chars_2 = compartment_2.split('')

  matches = chars_1 & chars_2
  matches[0]

end

# Open the strategy file and read the data.
rucksacks_file = File.open("inputs/day03_input.txt")
rucksacks_data = rucksacks_file.readlines.map{|line| line.chomp}
compartments_data = rucksacks_data.map{|line| [line[0..(line.length/2 - 1)], line[(line.length/2)..-1]]}

# Run a sanity check to compare the lengths of the two compartments (hopefully they are equal).
rucksacks_check = compartments_data.map{|one, two| [one.length, two.length]}

# There should be only one item type that appears in both compartments.
shared_items = compartments_data.map{|compartment_1, compartment_2| find_shared_item(compartment_1, compartment_2)}

# We can map these items to their priorities and get the total.
shared_item_priorities = shared_items.map{|char| priorities_lookup[char]}
q1_total = shared_item_priorities.sum

print "The sum of the priorities of the items which are shared across both rucksacks is #{q1_total}.\n"

# Problem 2

# Define a function to find the (assumed single) shared badge across a trio of rucksacks.
def find_shared_badge(sack_1, sack_2, sack_3)

  chars_1 = sack_1.split('')
  chars_2 = sack_2.split('')
  chars_3 = sack_3.split('')

  matches = chars_1 & chars_2 & chars_3
  matches[0]

end

# Process the rucksack data in threes and run fund_shared_badge on each group; then, repeat priority calcs as above.
elf_badges_data = rucksacks_data.each_slice(3).map {|slice| find_shared_badge(slice[0], slice[1], slice[2])}
badge_item_priorities = elf_badges_data.map{|char| priorities_lookup[char]}
q2_total = badge_item_priorities.sum

print "The sum of the priorities of the badges carried by the elves is #{q2_total}.\n"