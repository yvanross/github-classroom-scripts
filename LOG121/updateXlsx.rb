# https://github.com/weshatheleopard/rubyXL
#!/usr/bin/ruby -w
require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'rubyXL'
end

puts 'Gems installed and loaded!'

require 'rubyXL/convenience_methods'

notes = "/Users/rossypro/sources/ets/github-classroom-scripts/log121/LOG121-notes.txt"
workbook1 = RubyXL::Parser.parse("/Volumes/GoogleDrive/Mon disque/S20212-charge-laboratoire/LOG121/LOG121_04_20212.xlsx")
# workbook2 = RubyXL::Parser.parse("/Volumes/GoogleDrive/Mon disque/S20211-charge-laboratoires/LOG121/G05/LOG121_05_20211.xlsx")

signets=[workbook1.worksheets[0]]

def findColMetric(signet,metric)
    # p metric
    for col in 0..50
      break if signet[0][col].nil?
        # puts "#{col}=#{signet[0][col].value}"
        if signet[0][col].value == metric
            return col;
        end
    end
    return nil
end

def findRowCode(signet,first_row,index_col_code,code)
    for row in 0..100
        unless signet[row].nil? || signet[row][index_col_code].nil?
            # puts "#{row} - #{signet[row][index_col_code].value}  == #{code}"
            if signet[row][index_col_code].value == code
                return row
            end
        end
    end
    return nil
end

def updateSignets(signets,code,metric,note)
    updated = false
    signets.each do |signet|
        index_col_metric = findColMetric(signet,metric)
        index_col_code = findColMetric(signet,"Code universel")
        index_row_code = findRowCode(signet,5,index_col_code,code)

        unless(index_row_code.nil? || index_col_metric.nil?)
            puts "SUCCESS #{code} #{metric} #{note}"
            signet.add_cell(index_row_code,index_col_metric,note)
            updated = true
        end
    
    end
    if(!updated)
        puts "FAILURE #{code} #{metric}  ****************"
    end
end

#  ****************** main code ************
File.open(notes).each do |line|
    info = line.split(";")
    code = info[0]
    metric = info[1]
    note = info[2].sub(/[\r\n]/,'')
    updateSignets(signets,code,metric,note)
end

workbook1.write()
# workbook2.write()

