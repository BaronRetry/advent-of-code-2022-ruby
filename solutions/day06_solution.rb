### Advent of Code 2022 - Day 2

## Problem 1

# Open the datastream file and read the tokens.
datastream_file = File.open("inputs/day06_input.txt")
datastream = datastream_file.read.chomp
tokens = datastream.split('')

# Define a function that finds unique strings of a given length.
def find_unique_strings_of_length(tokens, sentinel_length)
  tokens.each_with_index do |char, i|
    if i < (sentinel_length - 1)
      false
    else
      sentinel = tokens[(i - (sentinel_length - 1))..i]
      if sentinel.uniq.length == sentinel.length
        print "Found the sentinel #{sentinel} at #{i + 1}.\n"
        break
      end

    end
  end
end

# For Problem 1, find location of unique strings of length 4.
find_unique_strings_of_length(tokens, 4)


# Problem 2

# For Problem 2, find location of unique strings of length 14.
find_unique_strings_of_length(tokens, 14)

# Note that another way, using each_cons, makes this problem basically trivial:
q1_alt = datastream.chars.each_cons(4).find_index { |a| a.uniq.count == 4 } + 4
q2_alt = datastream.chars.each_cons(14).find_index { |a| a.uniq.count == 14 } + 14
