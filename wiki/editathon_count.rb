require 'mediawiki/butt'
require 'io/console'

MW = MediaWiki::Butt.new('https://ftb.gamepedia.com/api.php')
print 'Enter your username: '
USERNAME = gets.chomp.freeze
print 'Enter your password: '
PASSWORD = STDIN.noecho(&:gets).chomp.freeze

login_result = MW.login(USERNAME, PASSWORD)
unless login_result
  puts 'Failed to log in! Aborting!'
  exit 1
end

STAFF = ["Xbony2", "TheSatanicSanta", "Chocohead", "Retep998", "Sokratis12GR", "3tusk", "LuminousLizard"]
USERS = ["ImmortalPharaoh7", "KaBob799", "Heniousycthe", "Coolway99", "Jungalist81", "Franzmedia", "016Nojr", "Suchtie", "blockingHD", 'Jinbobo']
# No need for a Time object, as we are using the API directly.
START = '2016-06-13T13:57:36Z'
END_T = '2016-06-20T21:29:00Z'

# Gets the user's number of contributions during the editathon organized by normal, minor, and new.
# @params user [String] The username
# @return [Hash<Symbol, Fixnum>] :normal, :minor, :new_pages.
def contribs(user)
  params = {
    action: 'query',
    list: 'usercontribs',
    ucuser: user,
    uclimit: 5000,
    ucprop: 'flags|title',
    ucstart: START,
    ucend: END_T,
    ucdir: 'newer'
  }
  
  response = MW.post(params)
  normal = 0
  minor = 0
  new_pages = 0
  new_redirects = 0
  translations = 0
  response['query']['usercontribs'].each do |c|
    title = c['title']
    next if title.include?('200k Editathon')
    if title.start_with?('Translations:')
      translations += 1
      next
    end
    
    if c.key?('minor')
      minor += 1
    elsif c.key?('new')
      if MW.get_text(title).start_with?('#REDIRECT')
        new_redirects += 1
      else
        new_pages += 1
      end
    else
      normal += 1
    end
  end
  
  return { normal: normal, minor: minor, new_pages: new_pages, redirects: new_redirects, translations: translations }
end

# Gets the contributions and outputs it for the given array of users.
# @param ary [Array<String>] The users.
# @return [void]
def print_stuff(ary)
  ary.each do |user|
    edits = contribs(user)
    puts "#{user}: #{edits[:normal]} normal edits, #{edits[:minor]} minor edits, #{edits[:new_pages]} new pages (#{edits[:redirects]} redirects), #{edits[:translations]} translations"
  end
end


puts 'Getting information for normal user contributions during the editathon (eligible for prize)'
print_stuff(USERS)

puts "\n"
puts 'Getting information for staff contributions during the editathon (not eligible for prize)'
print_stuff(STAFF)
