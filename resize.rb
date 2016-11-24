#!/usr/bin/env ruby

require 'rubygems'
require 'find'
require 'rmagick'


path='/home/jean/Images/estavayer2016/Fête fédérale de lutte Estavayer 2016'

#Dir[ path + '/*'].each do |x|
#  puts x 
#end


Find.find(path) do |obj|
    # recherche les fichiers du type  _*JPG
    the_name = obj.split(path)[1]
    splited = the_name.to_s.split('/')
    #puts splited[-1].inspect
    if splited[-1] =~ /^_.*JPG$/
        # on peut les retailler
        new_image_name = path + '/resized/resized_640' + splited[-1]
        #puts new_image_name
        puts obj
        img = Magick::Image::read(obj.to_s).first
        i_copy = img.copy
        i_copy.resize! 0.1
        i_copy['tags']=splited.join(",")
        i_copy.write new_image_name
        #puts new_image_name
        #image = File.new(new_image_name, "w+")  
        #puts Image.resize( the_name , new_image_name , 640, 640)
        #image.close
    end
end
