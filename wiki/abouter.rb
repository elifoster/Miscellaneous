require 'mediawiki/butt'
require 'io/console'

BUTT = MediaWiki::Butt.new('https://ftb.gamepedia.com/api.php', { query_limit_default: 5000 })

print 'Username: '
USERNAME = gets.chomp
print 'Password: '
PASSWORD = STDIN.noecho(&:gets).chomp

exit 1 unless BUTT.login(USERNAME, PASSWORD)

DPLDIS_TEXT = <<EOF
# Copy from User:Xbony/dpl/dis
EOF

DPLDIS_ARY = DPLDIS_TEXT.split("\n")

SUMMARY = 'Add {{About}}'.freeze

DPLDIS_ARY.each do |page|
  text = BUTT.get_text(page)
  p page
  next if text.downcase.include?('<translate>')
  next if text.downcase.include?('{{infobox needed}}')
  next if text.downcase.include?('{{about|')
  modname = text[/\n\|mod=(.+)\n/, 1]
  next unless page.end_with?("(#{modname})")
  base_content = page.sub("(#{modname})", "").strip
  BUTT.edit(page, text.sub(/{{[Ii]nfobox(.*)\n/, "{{About|the #{base_content} from #{modname}||#{base_content}}}\n{{Infobox\\1\n"), true, true, SUMMARY)
  p "Edited #{page}"
end

