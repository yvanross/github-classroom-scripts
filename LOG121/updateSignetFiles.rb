# https://github.com/weshatheleopard/rubyXL
#!/usr/bin/ruby -w
require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'rubyXL'
end

puts 'Gems installed and loaded!'

require 'rubyXL/convenience_methods'

notes = RubyXL::Parser.parse("/Users/rossypro/sources/ets/github-classroom-scripts/log121/LOG121-notes.xlsx").worksheets[0]
workbook1 = RubyXL::Parser.parse("/Volumes/GoogleDrive/Mon disque/S20211-charge-laboratoires/LOG121/G03/LOG121_03_20211.xlsx")
workbook2 = RubyXL::Parser.parse("/Volumes/GoogleDrive/Mon disque/S20211-charge-laboratoires/LOG121/G05/LOG121_05_20211.xlsx")

signets=[workbook1.worksheets[0],workbook2.worksheets[0]]

def findColMetric(signet,metric)
    # puts metric
    for col in 0..50
        # puts "#{col} =#{signet[0][col].value}"
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

def updateNote(signets,worksheet,row)
    return if worksheet[row].nil?
    return if worksheet[row][0].nil?
   
    code = worksheet[row][0].value # Returns cell A1 in the worksheet
    # Assurez vous de séparer les données en plusieurs colonnes avec le point-virgule
    metric = worksheet[row][1].value # Returns cell A1 in the worksheet
    note = worksheet[row][2].value # Returns cell A1 in the worksheet
    if worksheet[row][3].nil?
        nom='Unknown'
    else
        nom = worksheet[row][3].value || "unk" # Returns cell A1 in the worksheet
    end
    # puts "#{row} => #{code} #{metric} #{note} #{nom}"

    updated = false
    signets.each do |signet|
        index_col_metric = findColMetric(signet,metric)
        index_col_code = findColMetric(signet,"Code universel")
        index_row_code = findRowCode(signet,5,index_col_code,code)

        unless(index_row_code.nil? || index_col_metric.nil?)
            puts "#{row+1} SUCCESS #{code} #{metric} #{note} #{nom}"
            signet.add_cell(index_row_code,index_col_metric,note)
            updated = true
        end
    
    end
    if(!updated)
        puts "#{row+1} FAILURE #{code} #{metric} #{note} #{nom} ****************"
  
    end



end

#  ****************** main code ************
for row in 0..200
    updateNote(signets,notes,row)
end

workbook1.write()
workbook2.write()

