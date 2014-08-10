#!/usr/bin/env ruby

# assignations
min = 1
max = 125
url1 = "https://content.wuala.com/contents/"
url2 = "Heinz_Wyler/Fotosammlung%20Heinz/Auftragsarbeiten/Bauprojekt%20neues%20Geburtshaus%20im%20Petit%20Moncor/Neues%20Geburtshaus/"
url3 = "%20PetitPrince.jpg/?dl=1&key=sU7ylQDOEwyD"
name = "PetitPrince.jpg"

require 'net/http'

# préparation des urls
urls = Hash.new
(min..max).to_a.each {
  |e|
  urls[ "#{format("%03d",e)}_" + name ] = url1 + url2 + "#{format("%03d",e)}" + url3
  }

#rapatriement des images
urls.each {|name, url |
  #puts name, url
  open('images/' + name , 'wb') do |file|
    file << open(url).read
  end
}
