require 'mediawiki/butt'

@mw = MediaWiki::Butt.new('https://ftb.gamepedia.com/api.php', query_limit_default: 'max', assertion: :bot, use_continuation: true)
@mw.login('username', 'password')

def parse(title)
  params = {
    action: 'parse',
    page: title,
    contentmodel: 'json',
    prop: 'limitreportdata'
  }
  data = @mw.post(params)['parse']['limitreportdata']
  cpu_time = data.select { |data_piece| data_piece['name'] == 'limitreport-cputime' }[0]['0'].to_f
  real_time = data.select { |data_piece| data_piece['name'] == 'limitreport-walltime' }[0]['0'].to_f
  ReportData.new(cpu_time, real_time)
end

navboxes = @mw.get_category_members('Mod navigation templates')
str = %({|class="wikitable sortable"\n)
str << "! Navbox !! CPU Time !! Real Time !! Language !! Lazy?\n"
navboxes.each do |navbox|
  str << "|-\n"
  content = @mw.get_text(navbox)
  is_lazy = content.start_with?('{{Navbox/Lazy')
  if is_lazy
    content_content = @mw.get_text("#{navbox}/content")
    is_lua = content_content.start_with?('{{Navbox/Lazy/content') # This template does the #invoke thing as described below
  else
    is_lua = content.start_with?('{{#invoke:Navbox')
  end
  
  report = parse(navbox)
  str << "| {{Tl|#{navbox.sub('Template:', '')}}} || #{report.cpu_time} || #{report.real_time} || #{is_lua ? 'Lua' : 'Wikitext'} || #{is_lazy.to_s.capitalize}\n"
end

str << "|}\n"
print str

class ReportData
  attr_reader :cpu_time
  attr_reader :real_time
  
  def initialize(cpu_time, real_time)
    @cpu_time = cpu_time.wrap_with_color
    @real_time = real_time.wrap_with_color
  end
end

class Float
  def wrap_with_color
    color = 'green'
    if self > 3
      color = 'darkred'
    elsif self > 2
      color = 'red'
    end

    "<span style=\"color: #{color}\">#{self} seconds</span>"
  end
end
