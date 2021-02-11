#!/usr/bin/ruby -w
require 'bundler/inline'
# https://github.com/octokit/octokit.rb
# https://github.com/piotrmurach/github
gemfile do
  source 'https://rubygems.org'
  gem 'pdfkit' # https://github.com/pdfkit/pdfkit
  gem 'wkhtmltopdf-binary'
end



# require 'pdfkit'
kit = PDFKit.new('https://github.com/cc-yvanross/s20211-log121-03-c04-decorateur-individuel-XavierBoucher/blob/master/src/main/java/Decorateur/Repas/Repas.java')
kit.to_file("hello.pdf")

exit 

remote='https://github.com/cc-yvanross/s20211-log121-05-c04-decorateur-individuel-'
remote_repas = "/blob/master/src/main/java/Decorateur/Repas/Repas.java"
remote_icoffee = "/blob/master/src/main/java/Decorateur/Coffee/ICoffee.java"

root = '/Users/rossypro/Downloads/LOG121-C04-decorateur'

directories = Dir.entries(root).select {|entry| File.directory? File.join(root,entry) and !(entry =='.' || entry == '..') }
puts directories
directories.each do |directory|
    groups = Dir.entries(File.join(root,directory)).select {|entry| File.directory? File.join(File.join(root,directory),entry) and !(entry =='.' || entry == '..') }
    puts "--------------"
    # puts File.join(root,directory)
    groups.each do |group|
        path = File.join(root,directory,group)
        remote_path = "#{remote}#{group}"
        # puts path
        # puts remote_path
       
        [*1...10].each do |i|
        begin
            puts "https://github.com/cc-yvanross/s20211-log121-03-c04-decorateur-individuel-XavierBoucher/blob/master/src/main/java/Decorateur/Repas/Repas.java"
            puts "#{remote_path}#{remote_repas}"
            repas = PDFKit.new("#{remote_path}#{remote_repas}")
            puts File.join(path,"correction-Repas.pdf")
            repas.to_file("correctionRepas#{i}.pdf")
            break
        rescue => ex
                puts "#{i} => #{ex}"
        end
        end
        puts "#{remote_path}#{remote_icoffee}"
        coffee = PDFKit.new("#{remote_path}#{remote_icoffee}")
        coffee.to_file(File.join(path,"correction-ICoffee.pdf"))
       
        puts "#{remote_path}/README.md"
        readme = PDFKit.new("#{remote_path}/README.md")
        readme.to_file(File.join(path,"correction-README.pdf"))
    end
end
# kit = PDFKit.new('https://github.com/yvanross/LOG121-C04-decorateur-solution/blob/main/src/main/java/Decorateur/Repas/Repas.java')
# kit.to_file("hello2.pdf")
