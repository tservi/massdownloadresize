#!/usr/bin/env ruby

require 'rubygems'
require 'find'
require 'rmagick'
include Magick

path='/home/jean/Images/lutte_suisse/27.08.2017_Unspunnen_Schwingfest_Interlaken/resized/'


Find.find(path) do |obj|
    # recherche les fichiers du type  _*JPG
    the_name = obj.split(path)[1]
    splited = the_name.to_s.split('/')
    #puts splited
    if splited[-1] =~ /^_.*JPG$/
        # on peut les retailler
        puts obj.to_s
        magick = Magick::Image.read ( obj.to_s )
        img = magick.first
        #img['Tags']= "Fête fédérale de lutte suisse, Estavayer 2016," + splited.join(",")
        img['Copyright'] = "Pascal Jan"
        img['Artist'] = "Pascal Jan"
        img['Technician'] = "Jean Tinguely Awais aka t-servi.com with rmagick"
        img[ 'Image Description' ] = "copyright Pascal Jan"
	img.resize! 0.1
        #img.resize_to_fill! 600, 400
        # begin the watermarking
        mark = Magick::Image.new( img.columns , img.rows) {self.background_color = "none"}
        draw = Magick::Draw.new
        # draw is used to add elements to an image like text
        draw.annotate(mark, 0, 0, 0, 0, "(C) 2017 Pascal Jan") do
          # place the text in the bottom right of the canvas
          draw.gravity = Magick::SouthEastGravity
          # set text height in points where 1 point is 1/72 inches
          draw.pointsize = 10
          draw.font_family = "Times" # set font
          draw.fill = "black" # set text color
          draw.stroke = "none" # remove stroke
        end
        #img1 = img.composite(mark, Magick::CenterGravity, Magick::SoftLightCompositeOp)
        img1 = img.dissolve(mark, 0.8, 0.2, Magick::CenterGravity)
        #img.resize! 0.5
        img1.write obj.to_s
    end
end
puts "Fini!"
