require 'nokogiri'
include Nokogiri
require_relative 'gun'

class DOM


  def initialize(xml)
    @xml = xml
  end

  def parse
    guns = []

    @xml.search('Gun').each do |item|

      gun = Gun.new
      gun.material = item.at('Material').text
      gun.model = item.at('Model').text
      gun.origin = item.at('Origin').text

      ttc = TTC.new
      ttc.cagePresense = item.at('TTC').at("CagePresense").text
      ttc.opticsPresense = item.at('TTC').at("OpticsPresense").text
      ttc.effectiveRange = item.at('TTC').at("EffectiveRange").text
      ttc.longrange = item.at('TTC').at("LongRange").text
      gun.TTC = ttc

      gun.handy = item.at('Handy').text
#puts(gun)
      guns.push(gun)

    end
    guns
  end
end

