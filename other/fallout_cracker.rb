# Assists in the cracking of terminals for Fallout: New Vegas. Simply follow the instructions.

words = []

FINISH = '**end**'.freeze

puts "Enter each word as a list. Finish the list by entering '#{FINISH}'"

loop do
    word = gets.chomp
    break if word == FINISH
    words << word
end

unique_lengths = words.map(&:length).uniq.size
if unique_lengths > 1
    s = unique_lengths > 2 ? 's' : ''
    puts "You entered #{unique_lengths} word#{s} that are not uniformly lengthed."
    exit 1
end

loop do
    print 'Enter the word you selected in the terminal: '
    selected = gets.chomp
    print 'Enter the number of characters that were correct (or q to exit): '
    correct = gets.chomp
    exit if correct == 'q'
    correct_num = correct.to_i
    
    words.delete_if do |word|
        valid_chars = []
        selected.chars.each_with_index do |char, index|
            valid_chars << char if word.chars[index] == char
        end
        valid_chars.size != correct_num
    end
    
    if words.size == 0
        puts 'No more words left in the list.'
        exit 0
    elsif words.size == 1
        puts "Remaining word is #{words[0]}."
        exit 0
    else
        puts 'Remaining words:'
        words.each { |word| puts "* #{word}" }
    end
end
