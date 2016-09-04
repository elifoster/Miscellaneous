require 'oocsv'

def time(value)
  color = 'green'
  if value.to_f > 2
    color = 'red'
  elsif value.to_f > 3
    color = 'darkred'
  end
  
  "<span style=\"color: #{color}\">#{value} seconds</span>"
end

STR = <<EOF
csv here
EOF

ary = OOCSV.read(STR)

ret = "{|class=\"wikitable sortable\"\n"
ret << "! Navbox !! CPU Time !! Real Time !! Lua\n"

ary.each do |entry|
  ret << "|-\n"
  ret << "| {{Tl|Navbox #{entry.Navbox}}} || #{time(entry.CPUTime)} || #{time(entry.RealTime)} || #{entry.Lua}\n"
end

ret << '|}'

print ret
