#!/usr/bin/ruby -w
# ines = Array.new
# File.open('test.txt').each { |line| lines << line }
require "readline"

# filename="README.md"
readme_file="squelette.md"
project_directories = [
  "/Users/rossypro/Downloads/LOG210/Lab0 (Individuel)",
]
output = File.open("notes.txt", 'w')
project_directories.each do |project_directory|
  # p project_directory

  metric = File.basename(project_directory)

  groupes = Dir.glob("#{project_directory}/*")
  groupes.each do |groupe|
    filename = File.join(groupe,'note.txt')
    note = File.open(filename).read
    note = note.sub('note','').sub(':','').sub(',','.').sub(' ','').sub(/[\r\n]/,'').sub('%','')
    filename = File.join(groupe,readme_file)
    File.open(filename).each do |line|
      if line.include? "codeMoodle"
        code = line.gsub(/<codeMoodle[12345678]>/,'').gsub(/<\/codeMoodle[1234567]>/,'').gsub(/[\r\n]/,'').gsub(' ','').gsub('-','')
        p "#{code};#{metric};#{note} =>  #{groupe}"
        output.puts("#{code};#{metric};#{note}")
      end
    end 
  
  end
end
output.close