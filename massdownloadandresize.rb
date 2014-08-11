#!/usr/bin/env ruby

# assignations
min = 1
max = 125
url1 = "https://content.wuala.com/contents/"
url2 = "Heinz_Wyler/Fotosammlung%20Heinz/Auftragsarbeiten/Bauprojekt%20neues%20Geburtshaus%20im%20Petit%20Moncor/Neues%20Geburtshaus/"
url3 = "%20PetitPrince.jpg/?dl=1&key=sU7ylQDOEwyD"
complement = "PetitPrince.jpg"

require 'open-uri'
require 'rubygems'
require 'ImageResize' # gem install ImageResize


# préparation des urls
urls = Hash.new
(min..max).to_a.each {
  |e|
  urls[ "#{format("%03d",e)}_" + complement ] = url1 + url2 + "#{format("%03d",e)}" + url3
  }

#rapatriement et taille des images
urls.each {|name, url |
  #puts name, url
  image = open('images/' + name + '.original.jpg' , 'wb')
  image << open(url).read
  Image.resize( 'images/' + name + '.original.jpg'  , 'images/' + name , 640, 640)
}

# nettoyage du répertoire
FileUtils.rm Dir.glob('images/*original*')

# au fait, inutile d'essayer sur MS windows open-uri fonctionne très mal ... ;-)