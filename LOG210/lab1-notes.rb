# https://github.com/weshatheleopard/rubyXL
#!/usr/bin/ruby -w
# ruby lab1-readnotes.rb /Users/rossypro/Downloads/LOG210-lab01/S20211-LOG210-03-LAB1-02-11-2021-03-21-52/S20211-LOG210-03-LAB-TEAM10/corrections notes.xlsx

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'rubyXL'
end

require 'rubyXL/convenience_methods'
require 'find'
puts 'Gems installed and loaded!'

NB_STUDENT  = 50
NB_METRIC = 30

class Signets
    attr_accessor :signets
    attr_accessor :workbook1
    attr_accessor :workbook2
    attr_accessor :workbook3
    
    def initialize()
        self.workbook1 = RubyXL::Parser.parse("/Volumes/GoogleDrive/Mon disque/S20211-charge-laboratoires/LOG210/S20211-LOG210-G01/LOG210_01_20211.xlsx")
        self.workbook2 = RubyXL::Parser.parse("/Volumes/GoogleDrive/Mon disque/S20211-charge-laboratoires/LOG210/S20211-LOG210-G02/LOG210_02_20211.xlsx")
        self.workbook3 = RubyXL::Parser.parse("/Volumes/GoogleDrive/Mon disque/S20211-charge-laboratoires/LOG210/S20211-LOG210-G03/LOG210_03_20211.xlsx")
        self.signets=[self.workbook1.worksheets[0],self.workbook2.worksheets[0],self.workbook3.worksheets[0]]
    end
    def findColMetric(signet,metric)
        for col in 0..NB_METRIC
            puts "metric: #{metric} not found" if signet[0][col].nil?

            if signet[0][col].value == metric
                return col;
            end
        end
        return nil
    end

    def findRowCode(signet,first_row,index_col_code,code)
        for row in 0..NB_STUDENT
            unless signet[row].nil? || signet[row][index_col_code].nil?
                if signet[row][index_col_code].value == code
                    return row
                end
            end
        end
        return nil
    end

    def updateNote(code,metric,note, nom)
        self.signets.each do |signet|
            index_col_code = findColMetric(signet,"Code universel")
            index_col_metric = findColMetric(signet,metric)
            index_row_code = findRowCode(signet,4,index_col_code, code)
            unless(index_row_code.nil? || index_col_metric.nil?)
                puts "SUCCESS #{code} #{metric} #{note} #{nom}"
                signet.add_cell(index_row_code,index_col_metric,note)
                return true
            end
        end
        puts "FAILURE #{code} #{metric} #{note} #{nom} ****************"
        return false
    end

    def close() 
        self.workbook1.write()
        self.workbook2.write()
        self.workbook3.write()
    end

end 


class Students
    attr_accessor :students
    def initialize(excel)
        self.students = []
        (1..5).each do |index|
            self.students << Student.new(excel,index)
        end
    end

    def display
        if self.students.nil?
            puts "STUDENTS not identified yet"
        else
            self.students.each  do |student|
                student.display() unless student.code.nil? || student.code.empty?
            end 
        end
    end

    def displayNotes(notes)
        self.students.each  do |student|
            notes.display(student) unless student.code.nil? || student.code.empty?
        end 
    end
    def updateNotes(signets,notes)
        self.students.each  do |student|
            notes.update(signets,student) unless student.code.nil? || student.code.empty?
        end 
    end
end

class Student
    attr_accessor :name 
    attr_accessor :code 
    attr_accessor :note 
    
    def initialize(excel,name_index)
        self.name = excel.worksheets[7][1][name_index].value if excel.worksheets[7][1][name_index]
        self.code = excel.worksheets[7][2][name_index].value if excel.worksheets[7][2][name_index]
        begin
            self.note = excel.worksheets[7][40][12 + name_index].value.round(1)
        rescue 
            self.note = 0
        end
    end
end

class Notes 
    attr_accessor :preliminaire
    attr_accessor :plan1
    attr_accessor :rapport1
    attr_accessor :plan2
    attr_accessor :rapport2
    attr_accessor :plan3
    attr_accessor :rapport3
    attr_accessor :implementation

    def initialize(excel)
        self.preliminaire = excel.worksheets[0][44][2].value.round(1)
        self.plan1 = excel.worksheets[1][8][5].value.round(1)
        self.rapport1 = excel.worksheets[2][44][2].value.round(1)
        self.plan2 = excel.worksheets[3][8][5].value.round(1)
        self.rapport2 = excel.worksheets[4][44][2].value.round(1)
        self.plan3 = excel.worksheets[5][8][5].value.round(1)
        self.rapport3 = excel.worksheets[6][44][2].value.round(1)
        begin
        self.implementation = excel.worksheets[7][40][11].value.round(1)
        rescue 
            self.implementation = 0.0
        end
    end

    def update(signets,student)
        signets.updateNote(student.code,'Correction intéractive rapport',self.preliminaire,student.name) if self.preliminaire > 0.01
        signets.updateNote(student.code,'Rapport #1',self.rapport1,student.name) if self.rapport1 > 0.01
        signets.updateNote(student.code,'Rapport #2',self.rapport2,student.name) if self.rapport2 > 0.01
        signets.updateNote(student.code,'Rapport #3',self.rapport3,student.name) if self.rapport3 > 0.01
        signets.updateNote(student.code,'Plan iteration #1',self.plan1,student.name) if self.plan1 > 0.01
        signets.updateNote(student.code,'Plan itération #2',self.plan2,student.name) if self.plan2 > 0.01
        signets.updateNote(student.code,'Plan itération #3',self.plan3,student.name) if self.plan3 > 0.01
        if(student.note > 0.01)
            signets.updateNote(student.code,'Implémentation',student.note,student.name)
        else 
            signets.updateNote(student.code,'Implémentation',self.implementation,student.name) if self.implementation > 0.01
        end
    end

end


def getFiles()
    files = []
    Find.find(ARGV[0]) do |path|
        files << path if path =~ /notes.xlsx$/
    end
    return files
end



def synchFiles(files)
    signets = Signets.new
    files.each do |file|
        puts   file
        excel = RubyXL::Parser.parse(file)
        notes = Notes.new(excel)
        students = Students.new(excel)
        # students.display()
        # notes.display()
        # students.displayNotes(notes)
        students.updateNotes(signets,notes)
    end
    signets.close()
end

puts "Start"
synchFiles(getFiles())