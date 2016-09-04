# == Intro ==
# This script goes through all of the new users since last June (2015) that have at least 
# 1 contribution (user list created manually from Special:Log; we don't have many new users,
# it took like no time), and compiles them into a wikitable with # of contributions, creation date,
# and whether they have a talk page or not. Those that do have talk pages, and have few contributions
# can be further investigated later for quality/type of comments put on their talk page.

require 'mediawiki/butt'

# As we can see here, we already don't have a high amount of people creating accounts and contributing.
# This may need to be further looked into, to see if we have gotten better, worse, or stayed the
# same in this regard.
STR = <<EOS
22:45, 22 June 2016 User account Xinitrc (Talk | contribs | block) was created 
01:16, 11 June 2016 User account Heniousycthe (Talk | contribs | block) was created 
22:22, 5 June 2016 User account Makukthegamer (Talk | contribs | block) was created 
12:53, 27 May 2016 User account Sokratis13GR (Talk | contribs | block) was created 
19:24, 23 May 2016 User account Papac20x6 (Talk | contribs | block) was created 
16:24, 16 May 2016 User account TheRadicalWalrus (Talk | contribs | block) was created 
08:31, 2 May 2016 User account Leonard202 (Talk | contribs | block) was created 
10:01, 30 April 2016 User account ThatOneOtaku (Talk | contribs | block) was created 
02:10, 26 April 2016 User account JSigbjorn (Talk | contribs | block) was created 
17:14, 24 April 2016 User account Electroduck1 (Talk | contribs | block) was created 
08:40, 17 April 2016 User account Dutchfirbidden (Talk | contribs | block) was created 
14:17, 9 April 2016 User account SlashSmash313 (Talk | contribs | block) was created 
12:24, 26 March 2016 User account Mah000124 (Talk | contribs | block) was created 
00:20, 24 March 2016 User account UndeadZain (Talk | contribs | block) was created 
16:03, 12 March 2016 User account Paulawe (Talk | contribs | block) was created 
15:46, 7 March 2016 User account Starwarsfan1011 (Talk | contribs | block) was created 
05:47, 26 February 2016 User account Marceronii (Talk | contribs | block) was created 
14:05, 21 February 2016 User account Aexeron (Talk | contribs | block) was created 
10:17, 19 February 2016 User account Cjo9900 (Talk | contribs | block) was created 
19:06, 4 February 2016 User account Vramlak (Talk | contribs | block) was created 
07:31, 13 January 2016 User account BoggyBolt (Talk | contribs | block) was created 
18:16, 3 January 2016 User account Whitemarsh (Talk | contribs | block) was created 
23:54, 2 January 2016 User account Lead0007 (Talk | contribs | block) was created 
08:25, 28 December 2015 User account FrankdeBruin (Talk | contribs | block) was created 
00:55, 26 December 2015 User account Akt0r (Talk | contribs | block) was created
16:32, 24 December 2015 User account Ril1302 (Talk | contribs | block) was created 
08:46, 13 December 2015 User account TheMadedOne (Talk | contribs | block) was created 
19:04, 21 November 2015 User account Blealtan (Talk | contribs | block) was created 
18:46, 1 November 2015 User account Godnroc (Talk | contribs | block) was created 
03:34, 25 October 2015 User account JustOneFeather (Talk | contribs | block) was created 
00:58, 22 October 2015 User account Poovent (Talk | contribs | block) was created 
07:44, 20 September 2015 User account Evnidetr (Talk | contribs | block) was created 
07:02, 7 September 2015 User account XXFurtiiVytiiZz (Talk | contribs | block) was created 
02:19, 14 August 2015 User account Raidau (Talk | contribs | block) was created 
05:26, 31 July 2015 User account Himikokun (Talk | contribs | block) was created
20:25, 29 July 2015 User account OlofEricson (Talk | contribs | block) was created 
13:09, 21 July 2015 User account Jacobmclemore123 (Talk | contribs | block) was created 
04:02, 18 July 2015 User account FreemanGT (Talk | contribs | block) was created 
06:10, 12 July 2015 User account Prgd7 (Talk | contribs | block) was created 
22:20, 20 June 2015 User account Pivilio (Talk | contribs | block) was created 
23:06, 5 June 2015 User account Velharnin (Talk | contribs | block) was created 
EOS

butt = MediaWiki::Butt.new('https://ftb.gamepedia.com/api.php')
butt.login('username', 'password')

Thing = Struct.new('Thing', :creation_date, :contribs, :username, :has_talk)
ary = []
STR.each_line do |x|
  captures = x.scan(/\d+:\d+, (.+) User account (.+) \(Talk/).first  
  date = captures[0]  
  name = captures[1]  
  contribs = butt.get_contrib_count(name)  
  has_talk = !butt.get_text("User talk:#{name}").nil?  
  ary << Struct::Thing.new(date, contribs, name, has_talk)  
end  

wikitable = "{|class=\"wikitable sortable\"\n! Username !! Date joined !! Contributions !! Has talk page?\n"
ary.each do |x|
  wikitable << "|-\n"
  wikitable << "| #{x.username} || #{x.creation_date} || #{x.contribs} || #{x.has_talk}\n"
end

wikitable << "|}"

print wikitable

# The wikitable printed here is available at User:TheSatanicSanta/Sandbox/EditorResearch.
