require 'nokogiri'
include Nokogiri
xsd = Nokogiri::XML::Schema(File.read('xml/guns.xsd'))
doc = Nokogiri::XML(File.read('xml/guns.xml'))

xsd.validate(doc).each do |error|
  puts error.message
end