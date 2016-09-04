# This script simply converts the wikitable for new users/contributors by month into CSV for the pChart.

TABLE = <<EOS
The table wikitext copied here
EOS

TABLE.each_line do |x|
  next if x.start_with?('|}') || !x.start_with?('|') || x.start_with?('|-')
  captures = x.scan(/\| (.+) \|\| (.+) \|\| (.+)\n/)
  date = captures[0]
  new_users = captures[1]
  new_contribs = captures[2]
  puts "#{date},#{new_users},#{new_contribs}"
end
