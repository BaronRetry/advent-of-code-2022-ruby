### Advent of Code 2022 - Day 1

## Problem 1

# Open the file
file = File.open("inputs/day01_input.txt")

# Read text into an array; delete newlines, convert to int
raw_data = file.readlines.map{|line| line.chomp.to_i}

# If calories are zero (corresponding to blanks in the text data) then that tells us we are reading the next elf.
elf_cutoff_indices = raw_data.map.with_index{|cals, index| if cals == 0 then index end}.compact

# Group data by elf.
elf_calorie_arrays = raw_data.enum_for(:slice_after).with_index { |_, i| elf_cutoff_indices.include?(i) }.to_a

# Find the total calories carried by each elf.
elf_calories = elf_calorie_arrays.map(&:sum)

# Find the maximum number of calories carried by any one elf.
max_calories = elf_calories.max

# Find which elf is carrying this amount (just for fun).
max_calories_elf = elf_calories.index(elf_calories.max)

# Print the solution to the first problem.
print "Elf \##{max_calories_elf} is carrying the most calories, a total of #{max_calories}.\n"

## Problem 2

# Find how many calories the 3 elves with the most calories are carrying.
top_3_calories = elf_calories.sort.last(3)

# Find the total number of calories these elves are carrying.
sum_of_top_3_calories = top_3_calories.sum

# Print the solution to the second problem.
print "The 3 elves carrying the most calories are carrying a total of #{sum_of_top_3_calories} calories.\n"


