# https://github.com/weshatheleopard/rubyXL
#!/usr/bin/ruby -w
# ruby lab1-readnotes.rb /Users/rossypro/Downloads/LOG210-lab01/S20211-LOG210-03-LAB1-02-11-2021-03-21-52/S20211-LOG210-03-LAB-TEAM10/corrections notes.xlsx

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'rubyXL'
end

puts 'Gems installed and loaded!'

require 'rubyXL/convenience_methods'
notes = RubyXL::Parser.parse(ARGV[0]+'/'+ARGV[1])
preliminaire = notes.worksheets[0][44][2].value.round(1)
plan1 = notes.worksheets[1][8][5].value.round(1)
rapport1 = notes.worksheets[2][44][2].value.round(1)
plan2 = notes.worksheets[3][8][5].value.round(1)
rapport2 = notes.worksheets[4][44][2].value.round(1)
plan3 = notes.worksheets[5][8][5].value.round(1)
rapport3 = notes.worksheets[6][44][2].value.round(1)
implementation = notes.worksheets[7][40][11].value.round(1)




puts "Corrrection intéractive rapport:#{preliminaire}"
puts "rapport #1:#{rapport1}"
puts "rapport #2:#{rapport2}"
puts "rapport #3:#{rapport3}"
puts "Plan iteration #1:#{plan1}"
puts "Plan itération #2:#{plan2}"
puts "Plan itération #3:#{plan3}"
puts "Implémentation:#{implementation}"


File.open(ARGV[0]+"/notes.txt", "w") { |f| 
    f.write "Corrrection intéractive rapport:#{preliminaire}
Plan iteration #1:#{plan1}
rapport #1:#{rapport1}
Plan itération #2:#{plan2}
rapport #2:#{rapport2}
Plan itération #3:#{plan3}
rapport #3:#{rapport3}
Implémentation:#{implementation}
    "
}