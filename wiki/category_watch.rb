require 'mediawiki/butt'
require 'io/console'

BUTT = MediaWiki::Butt.new('https://ftb.gamepedia.com/api.php', query_limit_default: 5000)

puts 'Please enter your username: '
USERNAME = gets.chomp
puts 'Please enter your password: '
PASSWORD = STDIN.noecho(&:gets).chomp
puts "\n"

unless BUTT.login(USERNAME, PASSWORD)
	puts "Login failed!"
	exit 1
end

puts 'Please enter the category you would like to watch: '
CATEGORY = gets.chomp

WATCHLIST = BUTT.get_full_watchlist

to_watch = []

BUTT.get_category_members(CATEGORY).each do |member|
	next if WATCHLIST.include?(member)
	to_watch << member
end

response = BUTT.watch(to_watch)

response.each do |page, value|
	if value.nil?
		puts "#{page} was watched, but does not exist"
	else
		puts "#{page} was#{value ? '' : 'not'} watched"
	end
end


